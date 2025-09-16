//
//  FullScreenVideosView.swift
//  Coverr_Model
//
//  Created by D F on 9/15/25.
//

import SwiftUI
import AVKit

// MARK: - Video Cell
struct VideoCell: View {
    let video: VideoHitsModel
    let isActive: Bool
    let fillMode: Bool
    
    var body: some View {
        if let urls = video.urls {
            VideoPlayerView(url: urls.mp4, isActive: isActive, fillMode: fillMode)
        } else {
            Color.black
                .overlay(Text("No Video").foregroundColor(.white))
        }
    }
}

// MARK: - FullScreen Video View
struct FullScreenVideosView: View {
    @Environment(VideosViewModel.self) var videosVM
    @State private var currentPage = 0
    @State private var fillMode = true // toggle fill or fit per video
    
    var body: some View {
        ZStack {
            SnapPagingView(pageCount: videosVM.allVideos.count, currentPage: $currentPage) { width, height in
                VStack(spacing:0) {
                    ForEach(Array(videosVM.allVideos.enumerated()), id: \.element.id) { index, video in
                        VideoCell(video: video, isActive: currentPage == index, fillMode: fillMode)
                            .frame(width: width, height: height)
                            .ignoresSafeArea()
                            .tag(index)
                    }
                }
            }
            .task {
                await videosVM.fetchVideos(reset: true)
            }
            
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        fillMode.toggle()
                    }) {
                        Image(systemName: fillMode ? "arrow.up.left.and.arrow.down.right" : "arrow.down.right.and.arrow.up.left")
                            .font(.system(size: 23, weight: .bold))
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding()
                    }
                }
                Spacer()
            }
        }
    }
}
#Preview {
    FullScreenVideosView()
        .environment(VideosViewModel())
}
