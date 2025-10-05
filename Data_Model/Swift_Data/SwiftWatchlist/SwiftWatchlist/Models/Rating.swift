//
//  Rating.swift
//  SwiftWatchlist
//
//  Created by D F on 9/23/25.
//

import SwiftData
import Foundation

@Model
class Rating {
    var value: Double // (0–10)
    var review: String?
    var createdAt: Date
    
    @Relationship(inverse: \Movie.rating) var movie: Movie? // one-to-one

    init(value: Double, review: String? = nil, createdAt: Date = .now) {
        self.value = value
        self.review = review
        self.createdAt = createdAt
    }
}
