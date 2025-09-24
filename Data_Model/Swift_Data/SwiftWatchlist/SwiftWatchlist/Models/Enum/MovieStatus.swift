//
//  MovieStatus.swift
//  SwiftWatchlist
//
//  Created by D F on 9/23/25.
//

import Foundation

enum MovieStatus: String, CaseIterable, Identifiable, Codable {
    case toWatch = "To Watch"
    case watching = "Watching"
    case watched = "Watched"
    
    var id: String { rawValue }
    var icon: String {
        switch self {
        case .toWatch: "⏳"
        case .watching: "▶️"
        case .watched: "✅"
        }
    }
}
