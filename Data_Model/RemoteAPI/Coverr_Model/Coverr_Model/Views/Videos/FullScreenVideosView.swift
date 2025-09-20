//
//  FullScreenVideosView.swift
//  Coverr_Model
//
//  Created by D F on 9/15/25.
//

import SwiftUI
import AVKit
import SwiftData

// MARK: - Video Cell
struct VideoCell: View {
    @Environment(NetworkMonitorHolder.self) private var networkHolder
    let video: VideoHitsModel
    let isActive: Bool
    let fillMode: Bool
    
    private var networkMonitor: NetworkMonitorProtocol { networkHolder.monitor }

    
    var body: some View {
        Group{
            if networkMonitor.isConnected, let urls = video.urls {
                VideoPlayerView(url: urls.mp4, isActive: isActive, fillMode: fillMode)
            } else {
                Color.black
                    .overlay(
                        VStack {
                            Image(systemName: "wifi.slash")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Text("Offline — video unavailable")
                                .foregroundColor(.white)
                        }
                    )
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(
            Text(video.tags?.joined(separator: ", ") ?? "Video")
        )
        .accessibilityValue(Text(isActive ? "Currently playing" : "Paused"))
        .accessibilityHint(Text("Swipe up or down to move between videos"))
    }
}

// MARK: - FullScreen Video View
struct FullScreenVideosView: View {
    @Environment(VideosViewModel.self) var videosVM
    @Environment(NetworkMonitorHolder.self) private var networkHolder
    @State private var currentPage = 0
    @State private var fillMode = true // toggle fill or fit per video
    @State private var selectedVideo: VideoHitsModel? = nil
    
    private var networkMonitor: NetworkMonitorProtocol { networkHolder.monitor }

    
    var body: some View {
        // ZStack layering: first = back (video), last = front (button/icon overlay)
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
                            .accessibilityHidden(true)
                    }
                    .accessibilityLabel(Text("Switch video scaling"))
                    .accessibilityValue(Text(fillMode ? "Currently in fill mode" : "Currently in fit mode"))
                    .accessibilityHint(Text("Toggles between fill and fit mode for the video"))
                    
                    
                }
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.4).delay(0.2)) {
                        selectedVideo = videosVM.allVideos[currentPage]
                    }
                }) {
                    Image(systemName: "info.circle" )
                        .font(.system(size: 23, weight: .bold))
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                        .frame(maxWidth:.infinity, alignment: .bottomTrailing)
                        .padding(.bottom, 40)
                        .accessibilityHidden(true)
                }
                .accessibilityLabel(Text("Show video details"))
                .accessibilityHint(Text("Displays detailed information about the current video"))
            }
        }
        .sheet(item: $selectedVideo) { video in
            VideoDetailsView(video: video)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: VideoEntityModel.self, VideoUrlsEntityModel.self)
    let context = ModelContext(container)
    let videosVM = VideosViewModel(context: context)
    
    let mockNetworkMonitor = MockNetworkMonitor(isConnected: false) // offline preview
    
    FullScreenVideosView()
        .environment(\.modelContext, context)
        .environment(videosVM)
        .environment(NetworkMonitorHolder(mockNetworkMonitor))
}
