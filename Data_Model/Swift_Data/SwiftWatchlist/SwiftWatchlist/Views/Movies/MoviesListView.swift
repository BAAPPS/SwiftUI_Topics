//
//  MoviesListView.swift
//  SwiftWatchlist
//
//  Created by D F on 9/26/25.
//

import SwiftUI
import SwiftData
import Kingfisher

struct MoviesListView: View {
    @Environment(MoviesViewModel.self) var movieVM
    @Query(sort: \Movie.title) var movies: [Movie]

    var body: some View {
            List(movies) { movie in
                NavigationLink(value: movie) {
                    HStack(spacing: 12) {
                        // Movie poster
                        KFImage(URL(string: movie.posterPath))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .clipped()
                            .accessibilityHidden(true)

                        // Movie title & optional info
                        VStack(alignment: .leading, spacing: 4) {
                            Text(movie.title)
                                .font(.headline)

                            if let year = movie.releaseYear {
                                Text("Released in \(year)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                            if let rating = movie.rating?.value {
                                HStack{
                                    Text("Rating:")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text((String(format:"%.1f" ,rating)))
                                        .font(.title2)
                                        .foregroundColor(.blue)
                                    Text("/")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text("10")
                                        .font(.title3)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }

                        Spacer()
                    }
                    .padding(.vertical, 8)
                    // Accessibility
                    .accessibilityElement(children: .combine)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityLabel(AccessibilityUtils.movieLabel(for: movie))
                    .accessibilityHint("Shows movie details when tapped")
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Movie.self, Genre.self, Tag.self, Rating.self,
        configurations: config
    )
    let context = ModelContext(container)
    
    MoviesListView()
        .environment(\.modelContext, context)
        .environment(MoviesViewModel(context: context))
}
