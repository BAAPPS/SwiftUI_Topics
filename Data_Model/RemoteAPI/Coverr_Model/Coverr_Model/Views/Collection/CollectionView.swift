//
//  CollectionView.swift
//  Coverr_Model
//
//  Created by D F on 9/21/25.
//

import SwiftUI
import SwiftData

struct CollectionView: View {
    @Environment(VideosViewModel.self) var videosVM
    @Binding var selectedVideo: VideoHitsModel?
    
    @Binding var videos: [VideoHitsModel]
    @State private var showFullScreen = false
    
    let cornerRadius: CGFloat = 12
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(videosVM.allCollections) { collection in
                        CollectionCardView(collection: collection, cornerRadius: cornerRadius)
                            .onTapGesture {
                                Task {
                                    await loadVideos(for: collection)
                                    showFullScreen = true
                                }
                            }
                    }
                }
                .padding()
            }
            .task {
                // Fetch collections on appear
                await videosVM.fetchCollections(reset: true)
                print("Collections loaded:", videosVM.allCollections)
            }
        }
        .sheet(isPresented: $showFullScreen) {
            FullScreenVideosView(
                videos: $videos,
                selectedVideo: $selectedVideo,
                dragOffset: .constant(0)
            )
        }
    }
    
    // MARK: - Load videos for a collection
    @MainActor
    private func loadVideos(for collection: CollectionHitModel) async {
        // Option 1: Use pre-fetched videos if available
        let preFetched = videosVM.allCollectionsVideo
            .filter { $0.collectionID == collection.id }
            .map { $0.video }
        
        if !preFetched.isEmpty {
            videos = preFetched
            return
        }
        
        // Option 2: Lazy fetch if no pre-fetched videos
        videos = await videosVM.fetchVideosForCollection(collectionID: collection.id)
        
        print(videos)
    }
}


#Preview {
    @Previewable @State var selectedVideo: VideoHitsModel? = .example
    @Previewable @State var videos: [VideoHitsModel] = [.example]
    
    let container = try! ModelContainer(for: VideoEntityModel.self, VideoUrlsEntityModel.self)
    let context = ModelContext(container)
    
    let videosVM = VideosViewModel(context: context)
    videosVM.allCollections = [
        CollectionHitModel.example,
    ]
    
    return CollectionView(selectedVideo: $selectedVideo, videos:$videos)
        .environment(\.modelContext, context)
        .environment(videosVM)
        .environment(NetworkMonitorHolder(MockNetworkMonitor(isConnected: true)))
}
