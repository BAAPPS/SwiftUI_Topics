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
    @State private var showEditMode = false
    @State private var noteToEdit: Note? = nil
    
    @State private var noteToDelete: Note? = nil
    @State private var noteDeleteConfirmation = false
    
    @State private var showFavoriteView = false
    
    
    private var notesByType: [NoteType: [Note]] {
        Dictionary(grouping: notes) { $0.type }
    }
    
    var body: some View {
        List {
            NotesSectionedListView(
                notes: notes,
                showActions: showEditMode,
                onToggleFavorite: { note in noteVM.toggleFavorite(note) },
                onEdit: { note in noteToEdit = note },
                onDelete: { note in
                    noteToDelete = note
                    noteDeleteConfirmation = true
                }
            )
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .navigationTitle("All Notes")
        .toolbar {
            ToolbarItem(placement:.principal) {
                Button(action: {
                    withAnimation {
                        showFavoriteView = true
                    }
                }){
                    Image(systemName: "heart.circle.fill")
                        .font(.title2)
                        .accessibilityHidden(true)
                }
                .accessibilityLabel("Your favorites notes")
                .accessibilityHint("You can check out your favorite notes here")
            }
            
            
            ToolbarItem(placement:.topBarTrailing) {
                Button(action: {
                    withAnimation {
                        showEditMode.toggle()
                    }
                }){
                    Image(
                        systemName: showEditMode ? "x.circle" : "square.and.pencil"
                    )
                    .accessibilityHidden(true)
                }
                .accessibilityLabel(
                    showEditMode ? "Exit edit mode" : "Enter edit mode"
                )
                .accessibilityHint(
                    "You can update or delete notes in edit mode"
                )
            }
            ToolbarItem(placement:.topBarTrailing) {
                Button(action: { addNotesClicked = true }) {
                    Image(systemName: "plus")
                        .accessibilityHidden(true)
                }
                .accessibilityLabel("Add note")
                .accessibilityHint("Opens a screen to create a new note")
            }
        }
        .sheet(isPresented: $addNotesClicked) {
            NavigationStack {
                NoteView()
                    .environment(noteVM)
            }
        }
        .navigationDestination(isPresented: Binding(
            get: {noteToEdit != nil},
            set: {newValue in
                if !newValue { noteToEdit = nil}
            }
        )){
            if let note = noteToEdit {
                NoteView(note: note)
                    .environment(noteVM)
            }
        }
        .navigationDestination(isPresented: $showFavoriteView) {
            FavoritesNotes(favoriteNotes: notes.filter { $0.isFavorite })
                .environment(noteVM)
        }

        
        
        .alert(
            "Delete Note?",
            isPresented: $noteDeleteConfirmation,
            presenting: noteToDelete
        ) { note in
            Button("Delete", role: .destructive) {
                deleteNotes(note)
                noteToDelete = nil
                showEditMode = false
            }
            Button("Cancel", role: .cancel) {
                noteToDelete = nil
            }
        } message: { note in
            Text(
                "Are you sure you want to delete \"\(note.title)\"? This cannot be undone."
            )
        }
        
    }
    
    private func deleteNotes(_ note: Note) {
        noteVM.delete(note)
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
