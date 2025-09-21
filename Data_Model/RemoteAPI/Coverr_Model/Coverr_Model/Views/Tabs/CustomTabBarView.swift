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
    @Namespace private var animation
    var body: some View {
        ZStack{
            TabContentView(selectedTab: $selectedTab, selectedVideo: $selectedVideos, animaton: animation)
                .environment(videosVM)
            
            VStack{
                Spacer()
                TabBarView(selectedTab: $selectedTab)
                    .offset(y: selectedVideos != nil ? 100: 0)
                    .animation(.easeInOut(duration: 0.3), value: selectedVideos)
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
