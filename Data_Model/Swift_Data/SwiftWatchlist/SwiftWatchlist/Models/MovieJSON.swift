//
//  MovieJSON.swift
//  SwiftWatchlist
//
//  Created by D F on 9/24/25.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [MovieJSON]
}

struct MovieJSON: Decodable {
    var title: String
    var releaseYear: Int?
    var status: MovieStatus
    var createdAt: Date
    var overview: String
    var backdropPath: String
    var posterPath: String
    var genres: [GenreJSON]
    var tags: [TagJSON]
    var rating: RatingJSON?
}


struct GenreJSON: Decodable {
    var type: String
}

struct TagJSON: Decodable {
    var type: TagType?
    var name: String?
}

struct RatingJSON: Decodable {
    var value: Double
    var review: String?
    var createdAt: Date
}

