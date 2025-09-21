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
    @State private var selectedTab: AppTab = .all
    @State private var selectedVideos: VideoHitsModel? = nil
    @State private var dragOffset: CGFloat = 0
    
    
    @Namespace private var animation
    var body: some View {
        ZStack{
            TabContentView(selectedTab: $selectedTab, selectedVideo: $selectedVideos,dragOffset: $dragOffset, animaton: animation)
                .environment(videosVM)
            
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
