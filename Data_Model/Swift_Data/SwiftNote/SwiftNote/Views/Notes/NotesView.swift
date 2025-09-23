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
    
    
    private var notesByType: [NoteType: [Note]] {
        Dictionary(grouping: notes) { $0.type }
    }
    
    var body: some View {
        List {
            ForEach(NoteType.allCases, id: \.self) { type in
                if let notesForType = notesByType[type], !notesForType.isEmpty {
                    Section(header:
                                HStack {
                        Spacer()
                        Text(type.title)
                            .font(.title3)
                            .bold()
                        Spacer()
                    }
                        .padding(.vertical, 4)
                    ){
                        ForEach(notesForType) { note in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(note.title)
                                        .font(.headline)
                                    Text(note.content)
                                        .font(.subheadline)
                                    
                                }
                                Spacer()
                                
                                HStack(spacing: 8) {
                                    // Edit button
                                    Button(action: {
                                        noteToEdit = note
                                    }) {
                                        Image(systemName: "pencil")
                                            .foregroundColor(.blue)
                                            .accessibilityHidden(true)
                                    }
                                    .buttonStyle(BorderlessButtonStyle())    .opacity(showEditMode ? 1 : 0)
                                    .offset(x: showEditMode ? 0 : -20)
                                    .animation(.easeInOut(duration: 0.25), value: showEditMode)
                                    .accessibilityLabel("Edit note")
                                    .accessibilityHint("Opens the note to edit its title, content, and type")
                                    
                                    
                                    
                                    // Delete button
                                    Button(action: {
                                        noteToDelete = note
                                        noteDeleteConfirmation = true
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                            .accessibilityHidden(true)
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                    .opacity(showEditMode ? 1 : 0)
                                    .offset(x: showEditMode ? 0 : 20)
                                    .animation(.easeInOut(duration: 0.25), value: showEditMode)
                                    .accessibilityLabel("Delete note")
                                    .accessibilityHint("Removes this note permanently")
                                    
                                }
                                
                                
                            }
                            .padding(.vertical, 6)
                            .contentShape(Rectangle())
                        }
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .navigationTitle("All Notes")
        .toolbar {
            ToolbarItem(placement:.topBarTrailing) {
                Button(action: {
                    withAnimation {
                        showEditMode.toggle()
                    }
                }){
                    Image(systemName: showEditMode ? "x.circle" : "square.and.pencil")
                        .accessibilityHidden(true)
                }
                .accessibilityLabel(showEditMode ? "Exit edit mode" : "Enter edit mode")
                .accessibilityHint("You can update or delete notes in edit mode")
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
        .alert("Delete Note?", isPresented: $noteDeleteConfirmation, presenting: noteToDelete) { note in
            Button("Delete", role: .destructive) {
                deleteNotes(note)
                noteToDelete = nil
                showEditMode = false
            }
            Button("Cancel", role: .cancel) {
                noteToDelete = nil
            }
        } message: { note in
            Text("Are you sure you want to delete \"\(note.title)\"? This cannot be undone.")
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
