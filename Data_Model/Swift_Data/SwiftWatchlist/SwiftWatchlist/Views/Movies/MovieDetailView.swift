//
//  MovieDetailView.swift
//  SwiftWatchlist
//
//  Created by D F on 9/26/25.
//

import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    let movie: Movie
    var body: some View {
        VStack{
            KFImage(URL(string: movie.backdropPath))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .accessibilityHidden(true)
            
            VStack(spacing:10){
                // MARK: Movie Title
                Text(movie.title)
                    .font(.system(size: 17, weight: .bold))
                    .accessibilityLabel("Movie title: \(movie.title)")
                    .accessibilityAddTraits(.isHeader)
                
                // MARK: Release Date + Rating Group
                HStack(alignment:.center, spacing:10) {
                    if let releaseDate = movie.releaseYear {
                        IconTextRow(systemName: "calendar", text: "\(String(releaseDate))")
                    }
                    
                    dividerModifer()
                    
                    if let rating = movie.rating {
                        StarRatingView(rating: rating.value, starSize: 16)
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("Rating: \(rating.value) stars")
                    }
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel(releaseRatingAccessibilityLabel)
                
                // MARK: Genres
                HorizontalPillScroll(items: movie.genres, accessibilityLabel: "Movie genres") { genre in
                    IconTextPill(icon: genre.type.icon, text: genre.type.rawValue, color: .blue)
                }
                
                // MARK: Tags
                HorizontalPillScroll(items: movie.tags, accessibilityLabel: "Movie tags") { tag in
                    if let tagName = tag.name {
                        IconTextPill(icon: tag.icon, text: tagName, color: .orange)
                    }
                }
                
                
                // MARK: Overview
                Text(movie.overview)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.black.opacity(0.8))
                    .padding()
                    .lineSpacing(10)
                    .accessibilityLabel("Overview: \(movie.overview)")
                
                // MARK: Status
                IconTextPill(
                    icon: movie.status.icon,
                    text: movie.status.displayName,
                    color: .purple,
                    font: .system(size: 18, weight: .bold)
                )
                
            }
            .accessibilityElement(children: .contain)
            
            Spacer()
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(movie.title)
                    .font(.system(size: 14, weight: .bold))
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .accessibilityHidden(true)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    private var releaseRatingAccessibilityLabel: String {
        var components: [String] = []
        if let releaseDate = movie.releaseYear {
            components.append("Released in \(releaseDate)")
        }
        if let rating = movie.rating {
            components.append("Rating \(rating.value) stars")
        }
        return components.joined(separator: ", ")
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: .exampleMovie)
    }
}
