//
//  CustomTabBarView.swift
//  Coverr_Model
//
//  Created by D F on 9/21/25.
//

import SwiftUI
import SwiftData

struct CustomTabBarView: View {
    @Environment(VideosViewModel.self) var videosVM
    @Environment(NetworkMonitorHolder.self) var networkHolder
    @State private var selectedTab: AppTab = .all
    @State private var selectedVideos: VideoHitsModel? = nil
    @State private var dragOffset: CGFloat = 0
    @State private var allTabVideos: [VideoHitsModel] = []
    @State private var collectionTabVideos: [VideoHitsModel] = []
    
    
    private var networkMonitor: NetworkMonitorProtocol { networkHolder.monitor }
    
    
    @Namespace private var animation
    var body: some View {
        ZStack{
            TabContentView(selectedTab: $selectedTab,
                           selectedVideo: $selectedVideos,
                           allTabVideos: $allTabVideos,
                           collectionTabVideos: $collectionTabVideos,
                           dragOffset: $dragOffset, animaton: animation)
            .environment(videosVM)
            .task(id: selectedTab) {
                switch selectedTab {
                case .all:
                    if allTabVideos.isEmpty {
                        await videosVM.loadVideosDependingOnNetwork(isConnected: networkMonitor.isConnected)
                        allTabVideos = videosVM.allVideos
                    }
                case .collection:
                    if collectionTabVideos.isEmpty {
                        
                        if let firstCollection = videosVM.allCollections.first {
                            let videos = await videosVM.fetchVideosForCollection(collectionID: firstCollection.id, reset: true)
                            collectionTabVideos = videos
                        }
                    }
                }
            }

            
            VStack{
                Spacer()
                TabBarView(selectedTab: $selectedTab)
                    .offset(
                        y: selectedVideos != nil ? 100 : max(0, -dragOffset * 5)
                    )
                    .animation(.easeInOut(duration: 2), value: dragOffset)
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: VideoEntityModel.self, VideoUrlsEntityModel.self)
    let context = ModelContext(container)
    let videosVM = VideosViewModel(context: context)
    
    let mockNetworkMonitor = MockNetworkMonitor(isConnected: true)
    CustomTabBarView()
        .environment(\.modelContext, context)
        .environment(videosVM)
        .environment(NetworkMonitorHolder(mockNetworkMonitor))
}
