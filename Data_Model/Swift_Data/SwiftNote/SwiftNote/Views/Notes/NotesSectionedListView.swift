//
//  NotesSectionedListView.swift
//  SwiftNote
//
//  Created by D F on 9/23/25.
//

import SwiftUI

struct NotesSectionedListView: View {
    let notes: [Note]
    var showActions: Bool = false
    var onToggleFavorite: ((Note) -> Void)? = nil
    var onEdit: ((Note) -> Void)? = nil
    var onDelete: ((Note) -> Void)? = nil
    
    private var notesByType: [NoteType: [Note]] {
        Dictionary(grouping: notes) { $0.type }
    }
    
    var body: some View {
        ForEach(NoteType.allCases, id: \.self) { type in
            if let notesForType = notesByType[type], !notesForType.isEmpty {
                Section(
                    header: HStack {
                        Spacer()
                        Text(type.title)
                            .font(.title3)
                            .bold()
                        Spacer()
                    }
                        .padding(.vertical, 4)
                ) {
                    ForEach(notesForType) { note in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(note.title)
                                    .font(.headline)
                                Text(note.noteDescription)
                                    .font(.subheadline)
                                
                                if let bodyText = note.bodyText {
                                    Text(bodyText)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            Spacer()
                            
                            NoteActionButtonsView(
                                note: note,
                                showActions: showActions,
                                onToggleFavorite: onToggleFavorite,
                                onEdit: onEdit,
                                onDelete: onDelete
                            )
                        }
                        .padding(.vertical, 6)
                        .contentShape(Rectangle())
                    }
                }
            }
        }
    }
}


#Preview {
    NotesSectionedListView(notes: Note.sampleNotes)
        .padding()
}
