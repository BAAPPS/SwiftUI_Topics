//
//  ContentView.swift
//  Coverr_Model
//
//  Created by D F on 9/12/25.
//

import SwiftUI

struct ContentView: View {
    @State var videosVM = VideosViewModel()
    var body: some View {
        FullScreenVideosView()
            .environment(videosVM)
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
    ContentView()
}
