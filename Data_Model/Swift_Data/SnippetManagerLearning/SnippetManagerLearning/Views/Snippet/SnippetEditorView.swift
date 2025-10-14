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
                    
                    // Notes Preview
                    Text("Preview").font(.headline)
                    CustomMarkdownView(
                        blocks: snippetVM.markdownBlocks +
                        {
                            // Show placeholder
                            if snippetVM.content.isEmpty {
                                switch snippetVM.currentTypingBlockType {
                                case .header(let level): return [.header(level: level, text: snippetVM.placeholder)]
                                case .code: return [.code(language: nil, context: snippetVM.placeholder)]
                                case .component: return [.component(key: snippetVM.placeholder)]
                                case .paragraph, .none: return [.paragraph(text: snippetVM.placeholder)]
                                }
                            } else {
                                switch snippetVM.currentTypingBlockType {
                                case .header(let level): return [.header(level: level, text: snippetVM.content)]
                                case .code(let lang): return [.code(language: lang, context: snippetVM.content)]
                                case .component: return [.component(key: snippetVM.content)]
                                case .paragraph, .none: return [.paragraph(text: snippetVM.content)]
                                }
                            }
                        }()
                    )
                    .padding(.horizontal)
                    
                }
                .padding()
            }
            
  
            AutoResizingTextView(
                text: $snippetVM.content,
                height: $textViewHeight,
                onHeader: { level in snippetVM.switchTypingBlock(to: .header(level: level)) },
                onParagraph: { snippetVM.switchTypingBlock(to: .paragraph) },
                onCode: { snippetVM.switchTypingBlock(to: .code(language: snippetVM.language)) },
                onComponent: { snippetVM.switchTypingBlock(to: .component) }
            )
            .frame(height: textViewHeight)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .animation(.easeInOut(duration: 0.1), value: textViewHeight)
            .padding(.horizontal)
        }
        .navigationTitle(snippetToEdit == nil ? "New Snippet" : "Edit Snippet")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    Task {
                        do {
                            snippetVM.commitContentAsBlock(resetType: false)
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
               // If creating a new snippet, insert a draft once
               if snippetToEdit == nil && snippetVM.currentSnippet == nil {
                   snippetVM.createDraft(context: context)
               } else if let snippetToEdit {
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
