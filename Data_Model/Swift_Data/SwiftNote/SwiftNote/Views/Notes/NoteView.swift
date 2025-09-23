////
////  NoteView.swift
////  SwiftNote
////
////  Created by D F on 9/23/25.
////

import SwiftUI
import SwiftData

struct NoteView: View {
    @Environment(NoteViewModel.self) private var noteVM
    @Environment(\.dismiss) private var dismiss
    
    var note: Note?
    
    @State private var title = ""
    @State private var bodyText = ""
    @State private var description = ""
    @State private var type: NoteType = .personal
    
    @State private var showValidationAlert = false
    
    
    
    init(note: Note? = nil) {
        self.note = note
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                VStack(alignment: .leading){
                    Text("Note Type")
                        .font(.title3)
                        .bold()
                    
                    Picker("", selection: $type) {
                        ForEach(NoteType.allCases) { type in
                            Text(type.title).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .accessibilityLabel("Note Type")
                .accessibilityHint("Select the type of note: Personal, Work, Study, or Subject")
                
                // Title
                LabeledTextField(label: "Title", placeholder: "Enter title", text: $title)
                
                
                // Description / summary
                LabeledTextField(label: "Description", placeholder: "Enter a short description", text: $description)
                
                // Learning notes / body
                LabeledTextEditor(
                    label: "Learning Notes",
                    placeholder: "What are you learning for this note?",
                    text: $bodyText,
                    minHeight: 200
                )
                
            }
            .padding()
        }
        .navigationTitle(note == nil ? "New Note" : "Edit Note")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                .accessibilityLabel("Cancel")
                .accessibilityHint("Discards changes and closes this screen")
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                        description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        showValidationAlert = true
                    } else {
                        saveNote()
                    }
                }
                .accessibilityLabel("Save Note")
                .accessibilityHint("Saves the note and closes this screen")
            }
        }
        .onAppear{
            if let note = note {
                title = note.title
                if let bText = note.bodyText {
                    bodyText = bText
                }
                description = note.noteDescription
                type = note.type
            }
        }
        .alert("Missing Information", isPresented: $showValidationAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please enter both a title and a description before saving.")
        }
        
        
    }
    
    private func saveNote() {
        if let note = note {
            // Update existing note
            noteVM.updateNote(note: note, title: title, bodyText: bodyText, description: description,  type: type)
        } else {
            // Create new note
            noteVM.addNote(title: title, bodyText: bodyText, description: description, type: type)
        }
        title = ""
        bodyText = ""
        description = ""
        type = .personal
        dismiss()
    }
}

#Preview {
    let container = try! ModelContainer(for: Note.self)
    let context = ModelContext(container)
    
    NavigationStack {
        NoteView()
            .environment(\.modelContext, context)
            .environment(NoteViewModel(context: context))
    }
}


