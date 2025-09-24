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
    
    // Relationships
    @Relationship(deleteRule: .nullify) var genres: [Genre] = []
    @Relationship(deleteRule: .nullify) var tags: [Tag] = []
    @Relationship(deleteRule: .nullify) var rating: Rating?


    init(title: String,
         releaseYear: Int? = nil,
         status: MovieStatus = .toWatch,
         createdAt: Date = .now) {
        self.title = title
        self.releaseYear = releaseYear
        self.status = status
        self.createdAt = createdAt
    }
}
