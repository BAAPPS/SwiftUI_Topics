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
    var value: Double  // 0.5, 1.0, 1.5, ..., 5.0
    var review: String?
    var createdAt: Date
    
    @Relationship(inverse: \Movie.rating) var movie: Movie? // one-to-one

    init(value: Double, review: String? = nil, createdAt: Date = .now) {
        self.value = min(max(value, 0.5), 5.0) // clamp between 0.5 and 5
        self.review = review
        self.createdAt = createdAt
    }
}
