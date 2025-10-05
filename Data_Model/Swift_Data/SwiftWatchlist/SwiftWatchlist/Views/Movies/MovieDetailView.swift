//
//  MovieDetailView.swift
//  SwiftWatchlist
//
//  Created by D F on 9/26/25.
//

import SwiftUI
import Kingfisher
import SwiftData

struct MovieDetailView: View {
    @Environment(MoviesViewModel.self) var moviesVM
    @Bindable var movie: Movie
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
                    
                    dividerModifier()
                    
                    if let rating = movie.rating {
                        StarRatingView(
                              rating: rating.value,
                              starSize: 16,
                              showNumeric: true
                          )
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
                ScrollView {
                    Text(movie.overview)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(Color.black.opacity(0.8))
                        .padding()
                        .lineSpacing(10)
                        .accessibilityLabel("Overview: \(movie.overview)")
                }
                .padding(.vertical, 10)
                
                
                // MARK: - Watchlist Action Bar
                VStack(spacing: 12) {
                    HStack {
                        Text("Status:")
                            .font(.headline)
                            .foregroundColor(.purple)
                        Text(movie.status.displayName)
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                    
                    HStack(spacing: 16) {
                        if movie.status == .toWatch {
                            Button {
                                moviesVM.addToWatchinglist(movie)
                            } label: {
                                Label("Start Watching", systemImage: "play.circle.fill")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        
                        if movie.status == .watching {
                            Button {
                                moviesVM.addToWatched(movie)
                            } label: {
                                Label("Mark as Watched", systemImage: "checkmark.circle.fill")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        
                        if movie.status == .watched {
                            Button {
                                moviesVM.removeFromWatchlist(movie)
                            } label: {
                                Label("Remove", systemImage: "trash.circle.fill")
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
                .padding(.vertical)

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
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Movie.self, Genre.self, Tag.self, Rating.self,
        configurations: config
    )
    let context = ModelContext(container)
    NavigationStack {
        MovieDetailView(movie: .exampleMovie)
            .environment(MoviesViewModel(context: context))
    }
}
