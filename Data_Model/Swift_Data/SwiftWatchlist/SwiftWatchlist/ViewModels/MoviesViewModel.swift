//
//  MoviesViewModel.swift
//  SwiftWatchlist
//
//  Created by D F on 9/24/25.
//

import Foundation
import SwiftData

@Observable
class MoviesViewModel {
    private let context: ModelContext
    
    
    var movies: [Movie] = []
    
    init(context: ModelContext) {
        self.context = context
        loadMoviesFromJSON()
        
    }
    
    private func loadMoviesFromJSON() {
        if let response: MovieResponse = Bundle.main.decode("Movies.json") {
            print("Decoded \(response.results.count) movies")
            let moviesJSON = response.results
            
            for m in moviesJSON {
                let movie = Movie(
                    title: m.title,
                    releaseYear: m.releaseYear,
                    status: m.status,
                    createdAt: m.createdAt,
                    overview: m.overview,
                    backdropPath: m.backdropPath,
                    posterPath: m.posterPath
                )
                
                // Map genres
                movie.genres = m.genres.map { Genre(type: GenreType(rawValue: $0.type) ?? .action) }
                
                // Map tags
                movie.tags = m.tags.map {
                    if let type = $0.type {
                        return Tag(content: .predefined(type))
                    } else if let name = $0.name {
                        return Tag(content: .custom(name))
                    } else {
                        return Tag(content: .custom("Unknown"))
                    }
                }
                
                // Map rating
                if let r = m.rating {
                    let rating = Rating(value: r.value, review: r.review, createdAt: r.createdAt)
                    movie.rating = rating
                    rating.movie = movie
                }
                
                context.insert(movie)
                movies.append(movie) // optional, for UI
            }
            
            do {
                try context.save()
                print("Movies saved successfully!")
            } catch {
                print("Failed to save movies: \(error.localizedDescription)")
            }
            
        } else {
            print("Failed to decode Movies.json")
        }
    }

}
