//
//  Movies.swift
//  SwiftWatchlist
//
//  Created by D F on 9/23/25.
//

import Foundation
import SwiftData

@Model
class Movie {
    var title: String
    var releaseYear: Int?
    var status: MovieStatus
    var createdAt: Date
    var overview: String
    var backdropPath: String
    var posterPath: String
    
    // Relationships
    @Relationship(deleteRule: .nullify) var genres: [Genre] = []
    @Relationship(deleteRule: .nullify) var tags: [Tag] = []
    @Relationship(deleteRule: .nullify) var rating: Rating?
    
    
    init(title: String,
         releaseYear: Int? = nil,
         status: MovieStatus = .toWatch,
         createdAt: Date = .now,
         overview: String,
         backdropPath: String,
         posterPath: String) {
        self.title = title
        self.releaseYear = releaseYear
        self.status = status
        self.createdAt = createdAt
        self.overview = overview
        self.backdropPath = backdropPath
        self.posterPath = posterPath
    }
}

extension Movie {
    static let exampleMovies: [Movie] = [
        {
            let m = Movie(
                title: "Demon Slayer",
                releaseYear: 2025,
                status: .toWatch,
                overview: "...",
                backdropPath: "...",
                posterPath: "..."
            )
            m.rating = Rating(value: 4.5)
            return m
        }(),
        {
            let m = Movie(
                title: "War of the Worlds",
                releaseYear: 2025,
                status: .toWatch,
                overview: "...",
                backdropPath: "...",
                posterPath: "..."
            )
            m.rating = Rating(value: 3.0)
            return m
        }()
    ]
    
    static let exampleMovie: Movie = {
        let movie = Movie(
            title: "Demon Slayer: Kimetsu no Yaiba Infinity Castle",
            releaseYear: 2025,
            status: .toWatch,
            overview: "The Demon Slayer Corps are drawn into the Infinity Castle, where Tanjiro, Nezuko, and the Hashira face terrifying Upper Rank demons in a desperate fight as the final battle against Muzan Kibutsuji begins.",
            backdropPath: "https://image.tmdb.org/t/p/w1066_and_h600_bestv2/j7MKdRIwfJejNlJQG1hzjFJmtlH.jpg",
            posterPath: "https://media.themoviedb.org/t/p/w600_and_h900_bestv2/sUsVimPdA1l162FvdBIlmKBlWHx.jpg"
        )
        
        movie.rating = Rating(value: 4.5, review: "Amazing animation and fight scenes!")
        movie.genres = [
            Genre(type: .action),
            Genre(type: .animation),
            Genre(type: .drama)
        ]
        
        movie.tags = [
            Tag(content: .custom("Movie")),
            Tag(content: .custom("Japan")),
            Tag(content: .custom("Anime"))
        ]

        return movie
    }()
}
