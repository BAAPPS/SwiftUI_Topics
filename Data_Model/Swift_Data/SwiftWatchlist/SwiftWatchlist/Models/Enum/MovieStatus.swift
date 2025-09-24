//
//  MovieStatus.swift
//  SwiftWatchlist
//
//  Created by D F on 9/23/25.
//

import Foundation

enum MovieStatus: String, CaseIterable, Identifiable, Codable {
    case toWatch = "toWatch"
    case watching = "watching"
    case watched = "watched"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .toWatch: return "To Watch"
        case .watching: return "Watching"
        case .watched: return "Watched"
        }
    }
    
    var icon: String {
        switch self {
        case .toWatch: return "⏳"
        case .watching: return "▶️"
        case .watched: return "✅"
        }
    }
    
}
