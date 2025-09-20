//
//  VideoPlayerView.swift
//  Coverr_Model
//
//  Created by D F on 9/15/25.
//

import SwiftUI
import AVKit

/*
 SwiftUI Stack Layering Reference:
 
 ZStack (overlapping layers):
 - Elements are stacked back-to-front.
 - The first element is at the back.
 - The last element is drawn on top (frontmost).
 - Think of it as LIFO (Last In, First Out) for visual layering.
 - Example: Video -> Overlay -> Icon (Icon appears on top).
 
 VStack (vertical stacking):
 - Elements are arranged top-to-bottom.
 - The first element is at the top.
 - Subsequent elements are placed below.
 - Think of it as FIFO (First In, First Out) for visual order.
 The first item you add is seen first at the top.
 - Does NOT overlap unless explicitly offset.
 - Spacers can be used to push content (e.g., center icon vertically).
 
 HStack (horizontal stacking):
 - Elements are arranged left-to-right (or right-to-left in RTL layouts).
 - First element is on the leading edge.
 - Subsequent elements are placed next to the previous.
 - Overlap only if offsets or ZStack used inside.
 */


struct VideoPlayerView: View {
    let url: URL
    let isActive: Bool
    let fillMode: Bool
    @State private var player: AVPlayer? = nil
    @State private var showPlayPauseIcon = false
    @State private var isPlaying = false
    @State private var progress: Double = 0.0
    
    @State private var endObserver: Any? = nil
    
    @State private var timeObserver: Any? = nil
    
    
    var body: some View {
        GeometryReader { proxy in
            if let player = player {
                /*
                 Local ZStack layering note (see top-of-file SwiftUI Stack Layering Reference for full explanation):
                 - Video/player goes first (back).
                 - Overlay second.
                 - Play/Pause icons last (on top).
                 - Think LIFO: last element is frontmost.
                 */
                
                ZStack {
                    FullScreenAVPlayerView(player: player, fillMode: fillMode)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .clipped()
                        .ignoresSafeArea()
                        .onTapGesture {
                            togglePlayPause()
                        }
                        .accessibilityElement()
                        .accessibilityLabel(Text("Video player"))
                        .accessibilityValue(Text(isPlaying ? "Playing" : "Paused"))
                        .accessibilityHint(Text("Double tap to \(isPlaying ? "pause" : "play"). Swipe up/down to skip ±5 seconds."))
                        .accessibilityAdjustableAction { direction in
                            guard let currentItem = player.currentItem else { return }
                            let duration = currentItem.duration.seconds
                            let current = player.currentTime().seconds
                            
                            switch direction {
                            case .increment:
                                let newTime = min(current + 5, duration)
                                player.seek(to: CMTime(seconds: newTime, preferredTimescale: 600))
                            case .decrement:
                                let newTime = max(current - 5, 0)
                                player.seek(to: CMTime(seconds: newTime, preferredTimescale: 600))
                            @unknown default:
                                break
                            }
                        }
                    
                    // Subtle overlay on video
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .allowsHitTesting(false) // let taps pass through
                    
                }
                
                VStack{
                    Spacer()
                    // Play/Pause overlay icon
                    if showPlayPauseIcon {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .opacity(0.8)
                            .transition(.scale)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .accessibilityHidden(true)
                    }
                    
                    Spacer()
                    
                }
                VStack {
                    Spacer() // pushes progress bar to bottom
                    ProgressView(value: progress)
                        .progressViewStyle(LinearProgressViewStyle(tint: .white))
                        .padding(.horizontal)
                        .padding(.bottom, 50)
                        .accessibilityHidden(true)
                }
            } else {
                Color.black.ignoresSafeArea()
            }
        }
        .onAppear {
            let avPlayer = AVPlayer(url: url)
            player = avPlayer
            
            // Observe when video ends
            endObserver = NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: avPlayer.currentItem,
                queue: .main
            ) { _ in
                isPlaying = false
                progress = 1.0
            }
            
            // Observe current time every 0.1s
            timeObserver = avPlayer.addPeriodicTimeObserver(
                forInterval: CMTime(seconds: 0.1, preferredTimescale: 600),
                queue: .main
            ) { time in
                if let duration = avPlayer.currentItem?.duration.seconds,
                   duration > 0 {
                    progress = time.seconds / duration
                }
            }
            
            if isActive {
                avPlayer.play()
                isPlaying = true
            }
        }
        .onChange(of: isActive) { _, newValue in
            guard let player = player else { return }
            if newValue {
                player.seek(to: .zero)
                player.play()
                isPlaying = true
            } else {
                player.pause()
                isPlaying = false
            }
        }
        .onDisappear {
            player?.pause()
            player = nil
            if let observer = endObserver { NotificationCenter.default.removeObserver(observer) }
            if let timeObserver = timeObserver { player?.removeTimeObserver(timeObserver) }
        }
    }
    
    private func togglePlayPause() {
        guard let player = player else { return }
        if isPlaying {
            player.pause()
            isPlaying = false
        } else {
            // Only restart if not at end
            if player.currentTime() >= player.currentItem?.duration ?? CMTime.zero {
                player.seek(to: .zero)
            }
            player.play()
            isPlaying = true
        }
        
        // Show icon briefly
        withAnimation {
            showPlayPauseIcon = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                showPlayPauseIcon = false
            }
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

