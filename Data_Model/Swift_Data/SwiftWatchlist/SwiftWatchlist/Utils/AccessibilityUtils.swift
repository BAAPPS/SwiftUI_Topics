//
//  AccessibilityUtils.swift
//  SwiftWatchlist
//
//  Created by D F on 9/26/25.
//

import Foundation

struct AccessibilityUtils {
    static func movieLabel(for movie: Movie) -> String {
        var components = [movie.title]

        if let year = movie.releaseYear {
            components.append("released in \(year)")
        }

        if let rating = movie.rating?.value {
            components.append("Rating: \(rating)")
        }

        // Optional: include genres or tags
        if !movie.genres.isEmpty {
            let genreList = movie.genres.map { $0.type.rawValue }.joined(separator: ", ")
            components.append(genreList)
        }

        return components.joined(separator: ", ")
    }
}
