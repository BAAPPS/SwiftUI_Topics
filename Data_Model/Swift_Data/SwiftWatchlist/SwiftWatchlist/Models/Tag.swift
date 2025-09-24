//
//  Tag.swift
//  SwiftWatchlist
//
//  Created by D F on 9/23/25.
//

import Foundation
import SwiftData

@Model
class Tag {
    var type: TagType?
    var name: String?
    
    @Relationship(inverse: \Movie.tags) var movies: [Movie] = []

    init(content: TagContent) {
        switch content {
        case .predefined(let type):
            self.type = type
        case .custom(let name):
            self.name = name
        }
    }
    
    var title: String {
        type?.rawValue ?? name ?? "Unknown"
    }
    
    var icon: String {
        type?.icon ?? "🏷"
    }
}
