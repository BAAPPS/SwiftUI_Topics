//
//  SnippetViewModel.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/13/25.
//

import Foundation
import SwiftUI
import Combine
import SwiftData

@MainActor
@Observable
final class SnippetViewModel: ModelContextInitializable {
    var title: String = "" {
        didSet { scheduleAutoSave() }
    }
    
    var content: String = "" {
        didSet {
            scheduleAutoSave()
        }
    }
    
    var language: Language = .swift {
        didSet { scheduleAutoSave() }
    }
    
    var placeholder: String = ""
    
    
    var markdownBlocks: [MarkdownBlock] = []
    
    var createdAt: Date = Date()
    
    // Loaded snippets from SwiftData
    var snippets: [Snippet] = []
    
    var currentSnippet: Snippet? = nil
    
    
    var currentTypingBlockType: TypingBlockType = .none
    
    
    // MARK: - Private properties
    
    private let parser = MarkdownParser()
    
    // SwiftData context
    private let context: ModelContext
    
    private var autoSaveTask: Task<Void, Never>?
    
    private var lastChangeTime: Date?
    
    
    // MARK: - Init
    required init(context: ModelContext) {
        self.context = context
        load()
    }
    
    // MARK: - Toolbar actions
    
    func switchTypingBlock(to newType: TypingBlockType) {
        if !content.isEmpty {
            commitContentAsBlock()
        }
        
        currentTypingBlockType = newType
        
        switch newType {
        case .header(let level): placeholder = "Header \(level)"
        case .paragraph: placeholder = "New Paragraph"
        case .code: placeholder = "// insert code here"
        case .component: placeholder = "Component"
        case .none: placeholder = ""
        }
    }
    
    
    
    func commitContentAsBlock(resetType: Bool = true) {
        let textToCommit = content.isEmpty ? placeholder : content
        guard !textToCommit.isEmpty else { return }
        
        switch currentTypingBlockType {
        case .header(let level):
            markdownBlocks.append(.header(level: level, text: textToCommit))
        case .paragraph:
            markdownBlocks.append(.paragraph(text: textToCommit))
        case .code(let language):
            markdownBlocks.append(.code(language: language, context: textToCommit))
        case .component:
            markdownBlocks.append(.component(key: textToCommit))
        case .none:
            markdownBlocks.append(.paragraph(text: textToCommit))
        }
        
        content = ""
        placeholder = ""
        if resetType {
            currentTypingBlockType = .none
        }
    }
    
    
    // MARK: - Auto Save
    private func scheduleAutoSave() {
        lastChangeTime = Date()
        
        autoSaveTask?.cancel()
        autoSaveTask = Task { [weak self] in
            guard let self else { return }
            
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            guard let last = lastChangeTime, Date().timeIntervalSince(last) >= 2 else { return }
            
            do {
                // Only include typing buffer if we have a draft/existing snippet
                try await saveSnippet(includeTypingBuffer: true)
            } catch {
                print("Failed auto-save: \(error.localizedDescription)")
            }
        }
    }
    
    
    // MARK: - Parsing
    
    private func parseMarkdown(from text: String) {
        markdownBlocks = parser.parse(text)
    }
    
    // MARK: - SwiftData CRUD
    
    func createDraft(context: ModelContext) {
         // Only create a draft if there isn't a current snippet already
         guard currentSnippet == nil else { return }

         let draft = Snippet(title: "", content: "", language: language)
         context.insert(draft)
         currentSnippet = draft
         snippets.append(draft)
     }
    
    
    func saveSnippet(includeTypingBuffer: Bool = false) async throws {
        guard let snippet = currentSnippet else { return } // only update the draft
        
        var blocksToSave = markdownBlocks
        if includeTypingBuffer && !content.isEmpty {
            switch currentTypingBlockType {
            case .header(let level):
                blocksToSave.append(.header(level: level, text: content))
            case .paragraph:
                blocksToSave.append(.paragraph(text: content))
            case .code(let lang):
                blocksToSave.append(.code(language: lang, context: content))
            case .component:
                blocksToSave.append(.component(key: content))
            case .none:
                blocksToSave.append(.paragraph(text: content))
            }
        }
        
        snippet.title = title
        snippet.content = blocksToSave.map { block in
            switch block {
            case .header(let level, let text): return String(repeating: "#", count: level) + " " + text
            case .paragraph(let text): return text
            case .code(_, let context): return "```\n\(context)\n```"
            case .component(let key): return "[[\(key)]]"
            }
        }.joined(separator: "\n")
        
        snippet.language = language
        snippet.createdAt = Date()
        
        try context.save()
    }
    
    
    func loadSnippet(_ snippet: Snippet) {
        self.currentSnippet = snippet
        self.title = snippet.title
        self.content = ""
        self.language = snippet.language
        self.createdAt = snippet.createdAt
        parseMarkdown(from: snippet.content)
    }
    
    
    func resetSnippet() {
        currentSnippet = nil
        title = ""
        content = ""
        markdownBlocks = []
        placeholder = ""
        currentTypingBlockType = .none
    }
    
    func updateSnippet(_ snippet: Snippet) async throws {
        snippet.title = title
        snippet.content = markdownBlocks.map { block in
            switch block {
            case .header(let level, let text): return String(repeating: "#", count: level) + " " + text
            case .paragraph(let text): return text
            case .code(_, let context): return "```\n\(context)\n```"
            case .component(let key): return "[[\(key)]]"
            }
        }.joined(separator: "\n")
        snippet.language = language
        snippet.createdAt = Date()
        try context.save()
    }
    
    func deleteSnippet(_ snippet: Snippet) async throws {
        context.delete(snippet)
        try context.save()
        if let index = snippets.firstIndex(of: snippet) {
            snippets.remove(at: index)
        }
    }
    // MARK: - SwiftData Load
    func load() {
        do {
            // Fetch all Snippet objects
            let request = FetchDescriptor<Snippet>(sortBy: [SortDescriptor(\.createdAt, order: .forward)])
            snippets = try context.fetch(request)
        } catch {
            print("Failed to load snippets: \(error.localizedDescription)")
        }
    }
    

}
