//
//  ContentView.swift
//  SwiftNote
//
//  Created by D F on 9/22/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State private var noteVM: NoteViewModel
    @Environment(\.dismiss) private var dismiss 
    
    init(context: ModelContext) {
       _noteVM = State(wrappedValue: NoteViewModel(context: context))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                NotesView()
                    .environment(noteVM)
            }
            .padding()
        }
    }
}

#Preview {
    // Create a SwiftData container for preview
    let container = try! ModelContainer(for: Note.self)
    let context = ModelContext(container)
    
    ContentView(context: context)
        .environment(\.modelContext, context)
  
}
