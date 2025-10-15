//
//  SnippetEditorView.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/13/25.
//

import SwiftUI
import SwiftData

struct SnippetEditorView: View {
    @Environment(\.modelContext) var context
    @Environment(SnippetViewModel.self) var snippetVM
    @Environment(\.dismiss) var dismiss
    @State private var textViewHeight: CGFloat = 100

    var snippetToEdit: Snippet? = nil

    var body: some View {
        @Bindable var snippetVM = snippetVM

        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Title").font(.headline)
                    TextField("Snippet title", text: $snippetVM.title)
                        .textFieldStyle(.roundedBorder)

                    Text("Language").font(.headline)
                    Picker("Language", selection: $snippetVM.language) {
                        ForEach(Language.allCases, id: \.self) { lang in
                            Text(lang.rawValue.capitalized).tag(lang)
                        }
                    }
                    .pickerStyle(.segmented)

                    Text("Preview").font(.headline)
                    CustomMarkdownView(
                        blocks: snippetVM.markdownBlocks + snippetVM.blocks.map { $0.toMarkdownBlock() }
                    )
                    .padding(.horizontal)
                }
                .padding()
            }

            Divider()

            ScrollView {
                VStack(spacing: 16) {
                    ForEach(Array($snippetVM.blocks.enumerated()), id: \.element.id) { index, $block in
                        EditableBlockView(
                            block: $block,
                            snippetVM: snippetVM,
                            textViewHeight: $textViewHeight
                        )
                    }
                }
                .padding()
            }
        }
        .navigationTitle(snippetToEdit == nil ? "New Snippet" : "Edit Snippet")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    Task {
                        do {
                            try await snippetVM.saveSnippet()
                            snippetVM.resetSnippet()
                            dismiss()
                        } catch {
                            print("Failed to save snippet: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
        .onAppear {
            if let snippetToEdit {
                snippetVM.loadSnippet(snippetToEdit)
            }
        }
    }
}


#Preview {
    // 1. Create an in-memory SwiftData container
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Snippet.self, configurations: config)
    let context = ModelContext(container)
    
    // 2. Create your ViewModel
    let snippetVM = SnippetViewModel(context: context)
    
    // 3. Provide context AND VM to the view
    SnippetEditorView()
        .environment(\.modelContext, context)
        .environment(snippetVM)
}
