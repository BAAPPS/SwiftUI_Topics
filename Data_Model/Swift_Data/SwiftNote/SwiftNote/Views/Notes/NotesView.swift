//
//  NotesView.swift
//  SwiftNote
//
//  Created by D F on 9/23/25.
//

import SwiftUI
import SwiftData

struct NotesView: View {
    @Environment(NoteViewModel.self) private var noteVM
    @Environment(\.modelContext) private var context
    @Query(sort: \Note.createdAt, order: .reverse) private var notes: [Note]
    
    @State private var addNotesClicked = false
    
    private var notesByType: [NoteType: [Note]] {
        Dictionary(grouping: notes) { $0.type }
    }
    
    var body: some View {
        List {
            ForEach(NoteType.allCases, id: \.self) { type in
                if let notesForType = notesByType[type], !notesForType.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        // Manual section header
                        Text(type.title)
                            .font(.title3)
                            .bold()
                            .padding(.vertical, 4)
                            .frame(maxWidth:.infinity, alignment: .center)
                        
                        // Notes list
                        ForEach(notesForType) { note in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(note.title)
                                    .font(.headline)
                                Text(note.content)
                                    .font(.subheadline)
                                Text(note.type.title)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 6)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .onDelete { indexSet in
                indexSet.map { notes[$0] }.forEach { note in
                    context.delete(note)
                    try? context.save()
                }
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .navigationTitle("All Notes")
        .toolbar {
            ToolbarItem(placement:.topBarTrailing) {
                Button(action: { addNotesClicked = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $addNotesClicked) {
            NavigationStack {
                NoteView()
                    .environment(noteVM)
            }
        }
    }
}


#Preview {
    let container = try! ModelContainer(for: Note.self)
    let context = ModelContext(container)
    
    NavigationStack {
        NotesView()
            .environment(\.modelContext, context)
            .environment(NoteViewModel(context: context))
    }
}
