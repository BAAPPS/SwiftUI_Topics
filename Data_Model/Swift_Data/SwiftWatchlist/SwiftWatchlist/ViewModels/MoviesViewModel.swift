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
        loadMoviesIfNeeded()
    }
    
    private func loadMoviesIfNeeded() {
        let request = FetchDescriptor<Movie>()
        let existingMovies = (try? context.fetch(request)) ?? []
        
        guard let response: MovieResponse = Bundle.main.decode("Movies.json") else {
            print("Failed to decode Movies.json")
            return
        }
        
        print("Decoded \(response.results.count) movies")
        
        for m in response.results {
            // Check if movie already exists
            if existingMovies.contains(where: { $0.title == m.title && $0.releaseYear == m.releaseYear }) {
                print("Skipping duplicate: \(m.title)")
                continue
            }
            
            // Insert movie
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
            movies.append(movie)
        }
        
        do {
            try context.save()
            print("Movies saved successfully!")
        } catch {
            print("Failed to save movies: \(error.localizedDescription)")
        }
    }
    
    
    func resetDatabase() {
        do {
            try context.delete(model: Movie.self)
            try context.delete(model: Genre.self)
            try context.delete(model: Tag.self)
            try context.delete(model: Rating.self)
            try context.save()
            print("Database wiped clean.")
        } catch {
            print("Failed to reset DB: \(error)")
        }
    }
    
    
}
