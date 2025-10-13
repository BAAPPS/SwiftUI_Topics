//
//  SnippetEditorView.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/13/25.
//

import SwiftUI
import SwiftData

struct SnippetEditorView: View {
    @Environment(SnippetViewModel.self) var snippetVM
    @Environment(\.dismiss) var dismiss
    
    // Optional: editing an existing snippet
    var snippetToEdit: Snippet? = nil
    
    
    var body: some View {
        @Bindable var snippetVM = snippetVM
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Title")
                    .font(.headline)
                TextField("Snippet title", text: $snippetVM.title)
                    .textFieldStyle(.roundedBorder)
                
                Text("Language")
                    .font(.headline)
                Picker("Language", selection: $snippetVM.language) {
                    ForEach(Language.allCases, id: \.self) { lang in
                        Text(lang.rawValue.capitalized).tag(lang)
                    }
                }
                .pickerStyle(.segmented)
                
                Text("Notes")
                    .font(.headline)
                TextEditor(text: $snippetVM.content)
                    .font(.system(.body, design: .monospaced))
                    .scrollContentBackground(.hidden)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .frame(height: 400)
                
                Text("Preview")
                    .font(.headline)
                
                CustomMarkdownView(blocks: snippetVM.markdownBlocks)
                    .padding(.horizontal)
                
            }
            .padding()
            .navigationTitle(snippetToEdit == nil ? "New Snippet" : "Edit Snippet")
            .toolbar{
                ToolbarItem {
                    Button("Save") {
                        Task {
                            do {
                                if let snippet = snippetToEdit {
                                    try await snippetVM.updateSnippet(snippet)
                                    dismiss()
                                } else {
                                    try await snippetVM.saveSnippet()
                                    dismiss()
                                }
                                
                            }
                            catch {
                                print("Failed to save snippet: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Snippet.self, configurations: config)
    let context = ModelContext(container)
    let snippetVM = SnippetViewModel(context: context)
    SnippetEditorView()
        .environment(snippetVM)
}
