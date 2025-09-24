//
//  Genre.swift
//  SwiftWatchlist
//
//  Created by D F on 9/23/25.
//

import Foundation
import SwiftData

@Model
class Genre {
    var type: GenreType
    
    // Reverse relationship (many-to-many)
    @Relationship(inverse: \Movie.genres) var movies: [Movie] = []

    init(type: GenreType) {
        self.type = type
    }
}
