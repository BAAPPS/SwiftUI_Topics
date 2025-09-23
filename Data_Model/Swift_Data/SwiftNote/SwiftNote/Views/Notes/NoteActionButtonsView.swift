//
//  NoteActionButtonsView.swift
//  SwiftNote
//
//  Created by D F on 9/23/25.
//

import SwiftUI

import SwiftUI

struct NoteActionButtonsView: View {
    let note: Note
    let showActions: Bool
    let onToggleFavorite: ((Note) -> Void)?
    let onEdit: ((Note) -> Void)?
    let onDelete: ((Note) -> Void)?
    
    var body: some View {
        HStack(spacing: 8) {
            // Favorite
            if let toggleFavorite = onToggleFavorite {
                Button(action: { toggleFavorite(note) }) {
                    Image(systemName: note.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.pink)
                        .accessibilityHidden(true)
                }
                .buttonStyle(BorderlessButtonStyle())
                .opacity(showActions ? 1 : 0)
                .offset(x: showActions ? 0 : -10)
                .animation(.easeInOut(duration: 0.25), value: showActions)
                .accessibilityLabel(
                    note.isFavorite ? "Unfavorite note" : "Favorite note"
                )
                .accessibilityHint("Marks this note as favorite")
            }
            
            // Edit
            if let edit = onEdit {
                Button(action: { edit(note) }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.blue)
                        .accessibilityHidden(true)
                }
                .buttonStyle(BorderlessButtonStyle())
                .opacity(showActions ? 1 : 0)
                .offset(x: showActions ? 0 : -20)
                .animation(.easeInOut(duration: 0.25), value: showActions)
                .accessibilityLabel("Edit note")
                .accessibilityHint("Opens the note to edit its title, content, and type")
            }
            
            // Delete
            if let delete = onDelete {
                Button(action: { delete(note) }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .accessibilityHidden(true)
                }
                .buttonStyle(BorderlessButtonStyle())
                .opacity(showActions ? 1 : 0)
                .offset(x: showActions ? 0 : 20)
                .animation(.easeInOut(duration: 0.25), value: showActions)
                .accessibilityLabel("Delete note")
                .accessibilityHint("Removes this note permanently")
            }
        }
    }
}
#Preview {
    NoteActionButtonsView(
        note: Note.sampleNote,
        showActions: true,
        onToggleFavorite: { _ in print("Toggle favorite tapped") },
        onEdit: { _ in print("Edit tapped") },
        onDelete: { _ in print("Delete tapped") }
    )
    .padding()
}
