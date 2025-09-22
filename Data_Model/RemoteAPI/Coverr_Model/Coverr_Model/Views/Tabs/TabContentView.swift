//
//  TabContentView.swift
//  Coverr_Model
//
//  Created by D F on 9/21/25.
//

import SwiftUI
import SwiftData

struct TabContentView: View {
    @Environment(VideosViewModel.self) var videosVM
    @Binding var selectedTab: AppTab
    @Binding var selectedVideo: VideoHitsModel?
    @Binding var videos: [VideoHitsModel]
    @Binding var dragOffset: CGFloat
    var animaton:Namespace.ID
    var body: some View {
        switch selectedTab {
        case .all:
            FullScreenVideosView(videos:$videos, selectedVideo: $selectedVideo,dragOffset: $dragOffset)
                .environment(videosVM)

        case .collection:
            CollectionView( selectedVideo: $selectedVideo, videos:$videos)
                .environment(videosVM)
        }
    }
}

#Preview {
    @Previewable @State var selectedTab: AppTab = .all
    @Previewable @State var selectedVideo: VideoHitsModel? = .example
    @Previewable @State var videos: [VideoHitsModel] = [.example]
    @Previewable @Namespace var animation
    @Previewable @State var dragOffset: CGFloat = 0
    
    let container = try! ModelContainer(for: VideoEntityModel.self, VideoUrlsEntityModel.self)
    let context = ModelContext(container)
    let videosVM = VideosViewModel(context: context)
    let mockNetworkMonitor = MockNetworkMonitor(isConnected: true)
    
    TabContentView(selectedTab: $selectedTab, selectedVideo: $selectedVideo,videos:$videos, dragOffset: $dragOffset, animaton: animation)
        .environment(\.modelContext, context)
        .environment(videosVM)
        .environment(NetworkMonitorHolder(mockNetworkMonitor))
}
