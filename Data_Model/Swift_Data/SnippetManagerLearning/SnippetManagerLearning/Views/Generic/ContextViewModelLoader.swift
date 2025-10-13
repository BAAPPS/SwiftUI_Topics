//
//  ContextViewModelLoader.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/13/25.
//

import SwiftUI
import SwiftData

struct ContextViewModelLoader<VM: ModelContextInitializable & AnyObject, Content: View>: View {
    @Environment(\.modelContext) var context
    @State private var viewModel: VM? = nil
    
    let content: (VM) -> Content
    
    var body: some View {
        Group{
            if let vm = viewModel {
                content(vm)
            }
            else {
                ProgressView("Loading...")
            }
        }
        .onAppear {
            guard viewModel == nil else { return }
            let vm = VM(context: context)
            vm.load()
            viewModel = vm
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Snippet.self, configurations: config)
    let context = ModelContext(container)
    
    ContextViewModelLoader { (vm: SnippetViewModel) in
        VStack {
            Text("Loaded \(vm.snippets.count) snippets")
                .font(.headline)
            List(vm.snippets, id: \.id) { snippet in
                Text(snippet.title)
            }
        }
        .padding()
    }
    .environment(\.modelContext, context)
}
