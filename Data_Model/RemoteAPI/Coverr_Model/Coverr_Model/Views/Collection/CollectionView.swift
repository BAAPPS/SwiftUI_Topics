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
        NavigationStack {
            ZStack {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(videosVM.allCollections) { collection in
                            NavigationLink(destination: {
                                FullScreenVideosView(
                                    collectionID: collection.id ,
                                       videos: $videos,
                                       selectedVideo: $selectedVideo,
                                       dragOffset: .constant(0)
                                   )
                                .task {
                                    await loadVideos(for: collection)
                                }

                            }) {
                                CollectionCardView(collection: collection, cornerRadius: 12)
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
                .navigationTitle("Collections")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .tint(.white)
    }
    
    // MARK: - Load videos for a collection
    @MainActor
    private func loadVideos(for collection: CollectionHitModel) async {
        let firstPageVideos = await videosVM.fetchVideosForCollection(
            collectionID: collection.id,
            reset: true
        )
        videos = firstPageVideos
        
        print("Loaded \(videos.count) videos for collection:", collection.title)
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
