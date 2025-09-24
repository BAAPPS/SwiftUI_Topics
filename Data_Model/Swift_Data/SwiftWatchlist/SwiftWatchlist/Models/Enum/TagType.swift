//
//  TagType.swift
//  SwiftWatchlist
//
//  Created by D F on 9/23/25.
//

import Foundation


enum TagType: String, CaseIterable, Identifiable, Codable {
    case favorite = "Favorite"
    case mustWatch = "Must Watch"
    case classics = "Classics"
    case trending = "Trending"
    
    var id: String { rawValue }
    var icon: String {
        switch self {
        case .favorite: "❤️"
        case .mustWatch: "🔥"
        case .classics: "🏆"
        case .trending: "📈"
        }
    }
}
