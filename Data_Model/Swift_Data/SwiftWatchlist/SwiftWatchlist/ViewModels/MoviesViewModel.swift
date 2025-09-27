//
//  MoviesViewModel.swift
//  SwiftWatchlist
//
//  Created by D F on 9/24/25.
//

import Foundation
import SwiftData
import CoreData

@Observable
class MoviesViewModel {
    private let context: ModelContext
    
    
    var movies: [Movie] = []
    
    init(context: ModelContext) {
        self.context = context
        loadMoviesIfNeeded()
    }
    
    
    // MARK: - Create, Update, Delete Movies
    
    // Create Movies
    func addMovie(
        title: String,
        releaseYear: Int? = nil,
        status: MovieStatus = .toWatch,
        overview: String,
        backdropPath: String,
        posterPath: String,
        genres: [Genre] = [],
        tags: [Tag] = [],
        ratingValue: Double? = nil,
        ratingReview: String? = nil
    ) {
        if movieExists(title: title, releaseYear: releaseYear) {
            print("Skipping duplicate: \(title)")
            return
        }
        
        let movie = Movie(
            title: title,
            releaseYear: releaseYear,
            status: status,
            overview: overview,
            backdropPath: backdropPath,
            posterPath: posterPath
        )
        
        movie.genres = genres
        movie.tags = tags
        
        if let ratingValue = ratingValue {
            let rating = Rating(value: ratingValue, review: ratingReview)
            movie.rating = rating
            rating.movie = movie
        }
        
        context.insert(movie)
        
        do {
            try context.save()
            movies.append(movie) // keep local array updated
            print("Movie added: \(movie.title)")
        } catch {
            print("Failed to save new movie: \(error.localizedDescription)")
        }
        
    }
    
    
    
    
    
    // MARK: - Private Helpers
    
    private func loadMoviesIfNeeded() {
        guard let response: MovieResponse = Bundle.main.decode("Movies.json") else {
            print("Failed to decode Movies.json")
            return
        }
        
        print("Decoded \(response.results.count) movies")
        
        for m in response.results {
            // Check if movie already exists
            if movieExists(title: m.title, releaseYear: m.releaseYear) {
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
    
    
    private func resetDatabase() {
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
    
    private func movieExists(title: String, releaseYear: Int?) -> Bool {
        let normalized = title.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        // Broad fetch (could filter by releaseYear if provided)
        var descriptor = FetchDescriptor<Movie>()
        if let year = releaseYear {
            descriptor = FetchDescriptor(predicate: #Predicate { $0.releaseYear == year })
        }
        
        let candidates = (try? context.fetch(descriptor)) ?? []
        
        return candidates.contains { movie in
            movie.title.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == normalized
        }
    }
    
}
