//
//  ImageDetailView.swift
//  HarvardArtModel
//
//  Created by D F on 9/7/25.
//

import SwiftUI
import Kingfisher

struct ImageDetailView: View {
    let image: ImageModel
    var body: some View {
        VStack {
            
            // MARK: - Artwork Image
            KFImage.url(from:image.baseImageURL)
                .placeholder {
                    ZStack {
                        Color.black.opacity(0.2)
                        ProgressView()
                    }
                }
                .resizable()
                .scaledToFit()
                .accessibilityLabel(image.caption ?? "Artwork")
                .accessibilityAddTraits(.isImage)
            
            // MARK: - Copyright
            if let copyright = image.copyright {
                IconTextRow(systemName: "c.square.fill", text: copyright)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 5)
                    .frame(maxWidth:.infinity, alignment: .center)
            }
            
            // MARK: - Dates
            HStack{
                if let createdDate = image.createdDate {
                    IconTextRow(
                        systemName: "clock.fill",
                        text: createdDate.formattedDate()
                    )
                    .padding(.top, 5)
                }
                
                if image.createdDate != nil, image.date != nil {
                    shortDivider()
                        .padding()
                }
                
                
                if let postedDate = image.date {
                    IconTextRow(
                        systemName: "tray.and.arrow.down.fill",
                        text: postedDate.formattedLongDate()
                    )
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 5)
            .frame(maxWidth:.infinity, alignment: .center)
            /// Group child elements logically for VoiceOver without merging them.
            /// Each child remains individually accessible and is read in order.
            /// IconTextRow already handles accessibility by combining icon and text.
            // .accessibilityElement(children: .contain)
            
            if let lastUpdated = image.lastUpdated {
                IconTextRow(systemName: "clock.arrow.circlepath", text: lastUpdated.formattedLongDate())
            }
            
            
            if let format = image.format {
                IconTextRow(systemName: "photo", text: format)
                    .padding(.top, 10)
            }

            
            Spacer()
            
        }
        .navigationTitle(image.caption ?? "Artwork")
        .navigationBarTitleDisplayMode(.inline)
        .backButton()
    }
}

#Preview {
    let imagesVM  = ImagesViewModel()
    NavigationStack {
        ImageDetailView(image:imagesVM.exampleImage )
    }
    .navigationBarColor(background: .navyBlue, titleColor: .skyMist)
}
