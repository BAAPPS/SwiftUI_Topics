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
    var bodyText: String?
    var noteDescription: String
    var createdAt: Date
    var isFavorite: Bool
    var type: NoteType
    
    init(title: String, bodyText: String? = nil, noteDescription: String,createdAt: Date = .now, isFavorite: Bool = false, type: NoteType = .personal) {
        self.title = title
        self.bodyText = bodyText
        self.noteDescription = noteDescription
        self.createdAt = createdAt
        self.isFavorite = isFavorite
        self.type = type
    }
}

extension Note {
    static let sampleNotes: [Note] = [
        Note(
            title: "SwiftUI Basics",
            bodyText: "Exploring VStack, HStack, and ZStack.",
            noteDescription: "Learning layout containers",
            isFavorite: true,
            type: .study,
        ),
        Note(
            title: "Work Meeting Notes",
            bodyText: "Discussed Q3 OKRs and deadlines.",
            noteDescription: "Team sync summary",
            isFavorite: true,
            type: .work,
        )
    ]
    
    static let sampleNote =   Note(
        title: "SwiftUI Basics",
        bodyText: "Exploring VStack, HStack, and ZStack.",
        noteDescription: "Learning layout containers",
        isFavorite: true,
        type: .study,
    )
}



