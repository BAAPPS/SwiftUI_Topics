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
    @Environment(NetworkMonitorModel.self) var networkMonitor
    @State private var videosVM: VideosViewModel
    @State private var showOfflineBanner = false
    
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
                    
                    

                    if !networkMonitor.isConnected {
                        showOfflineBanner = true
                        Task {
                            try? await Task.sleep(nanoseconds: 5_000_000_000)
                            withAnimation {
                                showOfflineBanner = false
                            }
                        }
                    }
                }
            
            
            // Offline banner
            if showOfflineBanner {
                VStack {
                    Text("No Internet — videos are offline")
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(8)
                        .shadow(radius: 5)
                        .padding(.top, 20)
                    Spacer()
                }
                .transition(.move(edge: .top).combined(with: .opacity))
                .animation(.default, value: networkMonitor.isConnected)
            }
        }
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
    let container = try! ModelContainer(for: VideoEntityModel.self)
    let context = ModelContext(container)
    let networkMonitor = NetworkMonitorModel()
    
    ContentView(context: context)
        .environment(\.modelContext, context)
        .environment(networkMonitor)
}
