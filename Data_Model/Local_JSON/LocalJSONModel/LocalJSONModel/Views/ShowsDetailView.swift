//
//  ShowsDetailView.swift
//  LocalJSONModel
//
//  Created by D F on 9/2/25.
//

import SwiftUI
import Kingfisher

struct ShowsDetailView: View {
    let show: ShowsModel
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    

    
    var body: some View {
        ScrollView {
            VStack {
                KFImage.url(from: show.bannerImageUrl)
                    .placeholder {
                        ZStack {
                            Color.black.opacity(0.2)
                            ProgressView()
                        }
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .bannerSafeArea()
                    .accessibilityLabel("\(show.title) banner image")
                    .accessibilityAddTraits(.isImage)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 12){
                    
                    Text(show.subtitle).font(.title3)
                        .foregroundColor(Color(hex:"#540b0e"))
                        .bold()
                        .frame(maxWidth:.infinity, alignment: .center)
                    
                    HStack(alignment: .center, spacing: 8){
                        HStack(spacing: 8) {
                            Image(systemName: "tv")
                                .foregroundColor(.indigo.opacity(0.9))
                                .accessibilityHidden(true)
                            Text(show.schedule)
                                .font(.subheadline)
                                .foregroundColor(.black.opacity(0.7))
                        }
                        shortDivider()
                        HStack(spacing: 8) {
                            Image(systemName: "calendar")
                                .foregroundColor(.indigo.opacity(0.9))
                                .accessibilityHidden(true)
                            Text(show.year)
                                .font(.subheadline)
                                .foregroundColor(.black.opacity(0.7))
                        }
                        
                    }
                    .frame(maxWidth:.infinity, alignment: .center)
                    .padding()
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel(
                        "Subtitle: \(show.subtitle), Total Episodes: \(show.schedule), Release Year: \(show.year)"
                    )
                    
                    HStack(spacing: 8) {
                        Image(systemName: "person.2.fill")
                            .foregroundColor(.indigo.opacity(0.9))
                            .accessibilityHidden(true)
                        Text(show.cast.joined(separator: " | "))
                            .font(.subheadline)
                            .foregroundColor(.black.opacity(0.7))
                            .accessibilityLabel("Cast")
                            .accessibilityValue(show.cast.joined(separator: " | "))
                    }
                    
                    
                    Text(show.description)
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.7))
                    
                }
                .padding()
                
                Text("All Episodes")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.headline)
                    .padding(.vertical)
                
                
                Group {
                    let sortedEpisodes = show.episodes.dedupAndSort()
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(Array(sortedEpisodes.enumerated()), id: \.1.title) {  index,episode in
                            
                            let isLeftColumn = index % 2 == 0
                            
                            KFImage.url(from: episode.thumbnail_url)
                                .placeholder {
                                    ZStack {
                                        Color.black.opacity(0.2)
                                        ProgressView()
                                    }
                                }
                                .resizable()
                                .scaledToFill()
                                .frame(height: 100)
                                .clipped()
                                .cornerRadius(8, corners: isLeftColumn ? [.topRight, .bottomRight] : [.topLeft, .bottomLeft])
                                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                                .overlay(
                                    Text(episode.title)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .padding(6)
                                        .background(Color.black.opacity(0.6))
                                        .cornerRadius(4)
                                        .padding(4),
                                    alignment: .bottom
                                )
                        }
                    }
                }
            }
            .navigationTitle(show.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    NavigationStack {
        ShowsDetailView(show:.example)
    }
}
