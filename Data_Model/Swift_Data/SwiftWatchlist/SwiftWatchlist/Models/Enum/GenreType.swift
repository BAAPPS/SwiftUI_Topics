//
//  GenreType.swift
//  SwiftWatchlist
//
//  Created by D F on 9/23/25.
//

import Foundation

enum GenreType: String, CaseIterable, Identifiable, Codable {
    case action = "Action"
    case comedy = "Comedy"
    case drama = "Drama"
    case sciFi = "Sci-Fi"
    case horror = "Horror"
    
    var id: String { rawValue }
    var icon: String {
        switch self {
        case .action: "🎬"
        case .comedy: "😂"
        case .drama: "🎭"
        case .sciFi: "👽"
        case .horror: "👻"
        }
    }
}
