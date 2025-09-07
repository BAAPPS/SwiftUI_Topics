//
//  ImagesView.swift
//  HarvardArtModel
//
//  Created by D F on 9/7/25.
//

import SwiftUI
import Kingfisher

struct ImagesView: View {
    @Environment(ImagesViewModel.self) var imagesVM
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            // MARK: - Paging Images
            SnapPagingView(pageCount: imagesVM.images.count, currentPage: $currentPage) { width, height in
                VStack(spacing: 0) {
                    ForEach(imagesVM.images) { image in
                        KFImage.url(from: image.baseImageURL)
                            .placeholder {
                                ZStack {
                                    Color.black.opacity(0.2)
                                    ProgressView()
                                }
                            }
                            .resizable()
                            .scaledToFill()
                            .frame(width: width, height: height)
                            .clipped()
                            .overlayEffect()
                            .accessibilityLabel(image.caption ?? "Artwork")
                            .accessibilityAddTraits(.isImage)
                    }
                }
            }
            
            // MARK: - Info Button Overlay
            if imagesVM.images.indices.contains(currentPage) {
                let currentImage = imagesVM.images[currentPage]
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(value: currentImage) {
                            Image(systemName: "info.circle.fill")
                                .font(.title)
                                .padding(12)
                                .background(Color.red.opacity(0.7))
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                                .accessibilityLabel("Show details for \(currentImage.caption ?? "image")")
                                .accessibilityHint("Tap to view image details")
                        }
                        .padding(.trailing, 24)
                        .padding(.bottom, 64)
                    }
                }
            }
        }
        .navigationDestination(for: ImageModel.self) { image in
            ImageDetailView(image: image)
                .environment(imagesVM)
        }
        .navigationBarColor(background: .navyBlue, titleColor: .skyMist)
    }
}

#Preview {
    NavigationStack {
        ImagesView()
            .environment(ImagesViewModel())
    }
}
