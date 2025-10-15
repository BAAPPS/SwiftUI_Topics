//
//  SnippetDetailView.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/13/25.
//

import SwiftUI
import SwiftData

struct SnippetDetailView: View {
    @Environment(SnippetViewModel.self) var snippetVM
    let snippet: Snippet
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(snippet.title)
                    .font(.title)
                    .bold()
                
                Text(snippet.language.rawValue.capitalized)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Divider()
                
                CustomMarkdownView(blocks: MarkdownParser().parse(snippet.content))
                    .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle("\(snippet.title) Snippet")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            snippetVM.loadSnippet(snippet)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SnippetEditorView(snippetToEdit: snippet)
                    .environment(snippetVM)
                ) {
                    Image(systemName: "pencil")
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Snippet.self, configurations: config)
    let context = ModelContext(container)
    
    // Create dummy snippet for preview
    let dummySnippet = Snippet(
        title: "Hello World",
        content: """
        ```swift
        print("Hello World")
        ```
        """,
        language: .swift
    )
    
    context.insert(dummySnippet)
    
    // Create ViewModel
    let snippetVM = SnippetViewModel(context: context)
    snippetVM.loadSnippet(dummySnippet)
    
    return SnippetDetailView(snippet: dummySnippet)
        .environment(\.modelContext, context)
        .environment(snippetVM)
}
