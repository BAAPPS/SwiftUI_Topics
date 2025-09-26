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
                Text(movie.title)
                    .font(.system(size: 17, weight: .bold))
                    .accessibilityHidden(true)
                
                HStack(alignment:.center, spacing:10) {
                    if let releaseDate = movie.releaseYear {
                        IconTextRow(systemName: "calendar", text: "\(String(releaseDate))")
                    }
                    
                    dividerModifer()
                    
                    if let rating = movie.rating {
                        StarRatingView(rating: rating.value, starSize: 16)
                    }
                }
                
                HorizontalPillScroll(items: movie.genres) { genre in
                    IconTextPill(icon: genre.type.icon, text: genre.type.rawValue, color: .blue)
                }
                
                HorizontalPillScroll(items: movie.tags) { tag in
                    if let tagName = tag.name {
                        IconTextPill(icon: tag.icon, text: tagName, color: .orange)
                    }
                }
                
                
                Text(movie.overview)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.black.opacity(0.8))
                    .padding()
                    .lineSpacing(10)
                
                IconTextPill(
                    icon: movie.status.icon,
                    text: movie.status.displayName,
                    color: .purple,
                    font: .system(size: 18, weight: .bold)
                )
            
            }
            Spacer()
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(movie.title)
                    .font(.system(size: 14, weight: .bold))
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: .exampleMovie)
    }
}
