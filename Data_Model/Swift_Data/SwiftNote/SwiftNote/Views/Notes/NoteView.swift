//
//  NoteView.swift
//  SwiftNote
//
//  Created by D F on 9/23/25.
//

import SwiftUI
import SwiftData

struct NoteView: View {
    @Environment(NoteViewModel.self) private var noteVM
    @Environment(\.dismiss) private var dismiss
    
    var note: Note?
    
    @State private var title = ""
    @State private var content = ""
    @State private var type: NoteType = .personal
    
    
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
                
                LabeledTextField(label: "Title", placeholder: "Enter title", text: $title)
                
                LabeledTextEditor(
                    label: "Content",
                    placeholder: "Enter note content",
                    text: $content,
                    minHeight: 150
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
                    saveNote()
                }
                .accessibilityLabel("Save Note")
                .accessibilityHint("Saves the note and closes this screen")
            }
        }
        .onAppear{
            if let note = note {
                title = note.title
                content = note.content
                type = note.type
            }
        }
        
    }
    
    private func saveNote() {
        if let note = note {
            // Update existing note
            noteVM.updateNote(note: note, title: title, content: content, type: type)
        } else {
            // Create new note
            noteVM.addNote(title: title, content: content, type: type)
        }
        title = ""
        content = ""
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
