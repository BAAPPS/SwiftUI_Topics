//
//  ContentView.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/13/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @State private var snippetVM: SnippetViewModel
    
    init(context: ModelContext) {
    _snippetVM = State(wrappedValue: SnippetViewModel(context: context))
    }
    
    var body: some View {
        NavigationStack {
            SnippetListView()
                .environment(snippetVM)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Snippet.self, configurations: config)
    let context = ModelContext(container)
    
   ContentView(context: context)
        .environment(\.modelContext, context)
}
