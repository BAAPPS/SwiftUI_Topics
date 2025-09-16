//
//  VideoPlayerView.swift
//  Coverr_Model
//
//  Created by D F on 9/15/25.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let url: URL
    let isActive: Bool
    let fillMode: Bool
    @State private var player: AVPlayer? = nil

    var body: some View {
        GeometryReader { proxy in
            if let player = player {
                FullScreenAVPlayerView(player: player, fillMode: fillMode)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .clipped()
                    .ignoresSafeArea()
            } else {
                Color.black.ignoresSafeArea()
            }
        }
        .onAppear {
            let avPlayer = AVPlayer(url: url)
            player = avPlayer
            if isActive { avPlayer.play() }
        }
        .onChange(of: isActive) { _, newValue in
            if newValue {
                player?.seek(to: .zero)
                player?.play()
            } else {
                player?.pause()
            }
        }
        .onDisappear {
            player?.pause()
            player = nil
        }
    }
}


#Preview {
    VideoPlayerView(
        url: URL(string: "https://cdn.coverr.co/videos/coverr-photographer-in-mountains-7798/1080p.mp4")!,
        isActive: true,
        fillMode: true
    )
    .ignoresSafeArea()
}

