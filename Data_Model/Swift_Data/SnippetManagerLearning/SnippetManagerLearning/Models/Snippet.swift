//
//  Snippet.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/13/25.
//

import Foundation
import SwiftData

@Model
final class Snippet {
    @Attribute(.unique) var id: UUID
    var title: String
    var content: String
    var language: Language
    var createdAt: Date
    
    init(title: String, content: String, language: Language) {
        self.id = UUID()
        self.title = title
        self.content = content
        self.language = language
        self.createdAt = Date()
    }
}
