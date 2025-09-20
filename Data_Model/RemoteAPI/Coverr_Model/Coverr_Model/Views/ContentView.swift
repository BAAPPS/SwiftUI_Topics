//
//  ContentView.swift
//  Coverr_Model
//
//  Created by D F on 9/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context

    @Environment(NetworkMonitorHolder.self) private var networkHolder

    
    @State private var videosVM: VideosViewModel
    @State private var showOfflineBanner = false
    
    private var networkMonitor: NetworkMonitorProtocol { networkHolder.monitor }

    
    init(context: ModelContext) {
        _videosVM = State(wrappedValue: VideosViewModel(context: context))
    }
    
    
    var body: some View {
        ZStack {
            FullScreenVideosView()
                .environment(videosVM)
                .task(id: networkMonitor.isConnected) {
                    await videosVM.loadVideosDependingOnNetwork(isConnected: networkMonitor.isConnected)
                    await videosVM.loadCollectionsDependingOnNetwork(isConnected: networkMonitor.isConnected)
                    videosVM.testSwiftData()
                }
        }
        .networkBanner(using: networkMonitor)
    }
    
    // MARK: - Test All Endpoints
    private func testAllEndpoints() async {
        print("Fetching all videos…")
        await videosVM.fetchVideos(reset: true)
        print("All videos count:", videosVM.allVideos.count)
        
        print("Fetching all collections…")
        await videosVM.fetchCollections(reset: true)
        print("All collections count:", videosVM.allCollections.count)
        
        print("Fetching videos for all collections concurrently…")
        await videosVM.fetchAllCollectionsVideosConcurrently(reset: true)
        
        print("All collection videos count:", videosVM.allCollectionsVideo.count)
        print("✅ All endpoints tested successfully")
        
    }
}


#Preview {
    // Create a SwiftData container for preview
    let container = try! ModelContainer(for: VideoEntityModel.self)
    let context = ModelContext(container)
    
    // Use a mock network monitor for preview
    let mockNetworkMonitor = MockNetworkMonitor(isConnected: true)
    ContentView(context: context)
        .environment(\.modelContext, context)
        // Inject the mock network monitor wrapped in the holder
        .environment(NetworkMonitorHolder(mockNetworkMonitor))
}
