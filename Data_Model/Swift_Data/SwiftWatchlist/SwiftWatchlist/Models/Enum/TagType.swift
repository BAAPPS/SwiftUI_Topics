//
//  TagType.swift
//  SwiftWatchlist
//
//  Created by D F on 9/23/25.
//

import Foundation


enum TagType: String, CaseIterable, Identifiable, Codable, CustomStringConvertible {
    case favorite = "Favorite"
    case mustWatch = "Must Watch"
    case classics = "Classics"
    case trending = "Trending"
    
    var description: String { rawValue }
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .favorite: return "❤️"
        case .mustWatch: return "🔥"
        case .classics: return "🏆"
        case .trending: return "📈"
        }
    }
}
