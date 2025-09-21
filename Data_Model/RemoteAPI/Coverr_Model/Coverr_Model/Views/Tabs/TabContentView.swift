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
    var animaton:Namespace.ID
    var body: some View {
        switch selectedTab {
        case .all:
            FullScreenVideosView()
                .environment(videosVM)
        case .collection:
            Text("Collections")
        }
    }
}

#Preview {
    @Previewable @State var selectedTab: AppTab = .all
    @Previewable @State var selectedVideo: VideoHitsModel? = .example
    @Previewable @Namespace var animation
    
    let container = try! ModelContainer(for: VideoEntityModel.self, VideoUrlsEntityModel.self)
    let context = ModelContext(container)
    let videosVM = VideosViewModel(context: context)
    let mockNetworkMonitor = MockNetworkMonitor(isConnected: true)
    
    TabContentView(selectedTab: $selectedTab, selectedVideo: $selectedVideo, animaton: animation)
        .environment(\.modelContext, context)
        .environment(videosVM)
        .environment(NetworkMonitorHolder(mockNetworkMonitor))
}
