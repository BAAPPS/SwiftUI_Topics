//
//  NoteViewModel.swift
//  SwiftNote
//
//  Created by D F on 9/23/25.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class NoteViewModel{
    private let context: ModelContext
    
    
    init(context: ModelContext) {
        self.context = context
       
    }
    
    // MARK: - Create
    func addNote(title: String, content: String, type: NoteType = .personal, isFavorite: Bool = false){
        let note = Note(title: title, content: content,createdAt: .now, isFavorite: isFavorite, type: type)
        context.insert(note)
        save()
    }
    
    
    // MARK: Update
    
    func updateNote(note: Note, title:String, content: String, type: NoteType ) {
        note.title = title
        note.content = content
        note.type = type
        
        save()
    }
    
    func toggleFavorite(_ note: Note){
        note.isFavorite.toggle()
        save()
    }
    
    
    // MARK: - Delete
   func delete(_ note: Note) {
        context.delete(note)
        save()
    }
    
    // MARK: - Save Helper
    private func save() {
        do {
            try context.save()
        } catch {
            print("❌ Save failed: \(error.localizedDescription)")
        }
    }
    
}
