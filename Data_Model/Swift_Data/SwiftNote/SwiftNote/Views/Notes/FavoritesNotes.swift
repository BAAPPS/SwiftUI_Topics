//
//  FavoritesNotes.swift
//  SwiftNote
//
//  Created by D F on 9/23/25.
//

import SwiftUI
import SwiftData

struct FavoritesNotes: View {
    let favoriteNotes: [Note]
    
    private var favoritesByType: [NoteType: [Note]] {
        Dictionary(grouping: favoriteNotes) { $0.type }
    }
    
    var body: some View {
        List {
            if favoriteNotes.isEmpty {
                Text("No favorite notes yet.")
                    .foregroundColor(.secondary)
                    .italic()
            } else {
                NotesSectionedListView(notes: favoriteNotes)
            }
        }
        .navigationTitle("Favorites")
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    let container = try! ModelContainer(for: Note.self)
    let context = ModelContext(container)
    
    let sampleNotes: [Note] = [
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
    
    NavigationStack {
        FavoritesNotes(favoriteNotes: sampleNotes)
            .environment(\.modelContext, context)
            .environment(NoteViewModel(context: context))
    }
}
