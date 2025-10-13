//
//  SnippetListView.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/13/25.
//

import SwiftUI
import SwiftData

struct SnippetListView: View {
    @Environment(\.modelContext) var context
    @Environment(SnippetViewModel.self) var snippetVM
    var body: some View {
        List {
            ForEach(snippetVM.snippets, id:\.id) { snippet  in
                NavigationLink(value: snippet) {
                    VStack(alignment: .leading) {
                        Text(snippet.title)
                            .font(.headline)
                        Text(snippet.language.rawValue.capitalized)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onDelete(perform: deleteSnippet)
        }
        .navigationTitle("My Snippet")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SnippetEditorView().environment(snippetVM)
                ) {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationDestination(for: Snippet.self) {snippet in
            SnippetDetailView(snippet: snippet)
                .environment(snippetVM)
        }
    }
    
    private func deleteSnippet(at offsets: IndexSet) {
        Task {
            for index in offsets {
                let snippet = snippetVM.snippets[index]
                try await snippetVM.deleteSnippet(snippet)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Snippet.self, configurations: config)
    let context = ModelContext(container)
    let snippetVM = SnippetViewModel(context: context)
    SnippetListView()
        .environment(\.modelContext, context)
        .environment(snippetVM)
}
