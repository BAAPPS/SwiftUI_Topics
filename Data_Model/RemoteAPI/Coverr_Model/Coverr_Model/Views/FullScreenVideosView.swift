//
//  FullScreenVideosView.swift
//  Coverr_Model
//
//  Created by D F on 9/15/25.
//

import SwiftUI
import AVKit


struct FullScreenVideosView: View {
    @Environment(VideosViewModel.self) var videosVM
    @State private var currentPage = 0
    
    var body: some View {
        SnapPagingView(pageCount: videosVM.allVideos.count, currentPage: $currentPage) { width, height in
            VStack(spacing:0) {
                ForEach(Array(videosVM.allVideos.enumerated()), id: \.element.id) { index, video in
                    ZStack {
                        if let urls = video.urls {
                            VideoPlayerView(url: urls.mp4, isActive: currentPage == index)
                                .frame(width: width, height: height)
                                .ignoresSafeArea()
                        } else {
                            Color.black
                                .overlay(Text("No Video").foregroundColor(.white))
                                .frame(width: width, height: height)
                        }
                    }
                    .tag(index)
                }
            }
        }
        .task {
            await videosVM.fetchVideos(reset: true)
        }
    }
}
#Preview {
    FullScreenVideosView()
        .environment(VideosViewModel())
}
