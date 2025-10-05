//
//  GenreType.swift
//  SwiftWatchlist
//
//  Created by D F on 9/23/25.
//

import Foundation

enum GenreType: String, CaseIterable, Identifiable, Codable, CustomStringConvertible {
    case action = "Action"
    case comedy = "Comedy"
    case drama = "Drama"
    case sciFi = "Sci-Fi"
    case horror = "Horror"
    case animation = "Animation"
    case fantasy = "Fantasy"
    case thriller = "Thriller"
    case romance = "Romance"
    case documentary = "Documentary"
    
    var description: String { rawValue }
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .action: return "🎬"
        case .comedy: return "😂"
        case .drama: return "🎭"
        case .sciFi: return "👽"
        case .horror: return "👻"
        case .animation: return "🎨"
        case .fantasy: return "🪄"
        case .thriller: return "🕵️"
        case .romance: return "❤️"
        case .documentary: return "🎥"
        }
    }
}


