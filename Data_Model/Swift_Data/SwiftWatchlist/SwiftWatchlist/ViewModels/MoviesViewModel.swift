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
    
    init(context: ModelContext, skipJsonLoad: Bool = false) {
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
    
    // MARK: - Update Movie Status
    
    func cycleMovieStatus(for movie: Movie) {
        let allStatuses = MovieStatus.allCases
        guard let currentIndex = allStatuses.firstIndex(of: movie.status) else { return }
        
        let nextIndex = (currentIndex + 1) % allStatuses.count
        movie.status = allStatuses[nextIndex]
        
        saveMovieChanges(movie)
        refreshMovies()
    }
    
    
    // MARK: - Update Watch List
    
    func addToWatchinglist(_ movie: Movie) {
        movie.status = .watching
        saveMovieChanges(movie)
    }
    
    func addToWatched(_ movie: Movie) {
        movie.status = .watched
        saveMovieChanges(movie)
    }
    
    func removeFromWatchlist(_ movie: Movie) {
        movie.status = .toWatch
        saveMovieChanges(movie)
    }
    

    

    
    
    // MARK: - Private Helpers
    
    private func saveMovieChanges(_ movie: Movie) {
        do {
            try context.save()
            print("Updated status for: \(movie.title) to \(movie.status.displayName)")
        } catch {
            print("Failed to save movie status: \(error.localizedDescription)")
        }
    }
    
    private func refreshMovies() {
        do {
            self.movies = try context.fetch(FetchDescriptor<Movie>())
        } catch {
            print("Failed to refresh movies: \(error)")
        }
    }
    private func loadMoviesIfNeeded() {
        let existingMovies: [Movie] = (try? context.fetch(FetchDescriptor<Movie>())) ?? []
        guard existingMovies.isEmpty else {
            print("Movies already exist — skipping JSON load.")
            self.movies = existingMovies
            return
        }
        
        guard let response: MovieResponse = Bundle.main.decode("Movies.json") else {
            print("Failed to decode Movies.json")
            return
        }
        
        for m in response.results {
            let movie = Movie(
                title: m.title,
                releaseYear: m.releaseYear,
                status: m.status,
                createdAt: m.createdAt,
                overview: m.overview,
                backdropPath: m.backdropPath,
                posterPath: m.posterPath
            )
            
            movie.genres = m.genres.map { Genre(type: GenreType(rawValue: $0.type) ?? .action) }
            movie.tags = m.tags.map {
                if let type = $0.type {
                    return Tag(content: .predefined(type))
                } else if let name = $0.name {
                    return Tag(content: .custom(name))
                } else {
                    return Tag(content: .custom("Unknown"))
                }
            }
            
            if let r = m.rating {
                let rating = Rating(value: r.value, review: r.review, createdAt: r.createdAt)
                movie.rating = rating
                rating.movie = movie
            }
            
            context.insert(movie)
        }
        
        do {
            try context.save()
            self.movies = try context.fetch(FetchDescriptor<Movie>())
            print("Movies loaded and saved successfully!")
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
