//
//  FullscreenAVPlayerView.swift
//  Coverr_Model
//
//  Created by D F on 9/15/25.
//


import SwiftUI
import AVKit

struct FullScreenAVPlayerView: UIViewRepresentable {
    let player: AVPlayer
    var fillMode: Bool = true // true = aspectFill, false = aspectFit

    func makeUIView(context: Context) -> PlayerView {
        let view = PlayerView()
        view.player = player
        view.fillMode = fillMode
        return view
    }

    func updateUIView(_ uiView: PlayerView, context: Context) {
        uiView.player = player
        uiView.fillMode = fillMode
    }
}
