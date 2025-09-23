//
//  NoteModel.swift
//  SwiftNote
//
//  Created by D F on 9/23/25.
//

import Foundation
import SwiftData

@Model
class Note {
    var title: String
    var content: String
    var createdAt: Date
    var isFavorite: Bool
    var type: NoteType
    
    init(title: String, content: String, createdAt: Date = .now, isFavorite: Bool = false, type: NoteType = .personal) {
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.isFavorite = isFavorite
        self.type = type
    }
}
