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
    @State private var videos: [VideoHitsModel] = []
    
    private var networkMonitor: NetworkMonitorProtocol { networkHolder.monitor }
    
    
    @Namespace private var animation
    var body: some View {
        ZStack{
            TabContentView(selectedTab: $selectedTab, selectedVideo: $selectedVideos,videos: $videos, dragOffset: $dragOffset, animaton: animation)
                .environment(videosVM)
                .task {
                    if selectedTab == .all && videos.isEmpty {
                        // Load videos depending on network
                        await videosVM.loadVideosDependingOnNetwork(isConnected: networkMonitor.isConnected)
                        videos = videosVM.allVideos
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
