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
            parseMarkdown()
            scheduleAutoSave()
        }
    }
    
    var language: Language = .swift {
        didSet { scheduleAutoSave() }
    }
    
    
    var markdownBlocks: [MarkdownBlock] = []
    
    var createdAt: Date = Date()
    
    // Loaded snippets from SwiftData
    var snippets: [Snippet] = []
    
    var currentSnippet: Snippet? = nil
    
    
    
    
    // MARK: - Private properties
    private let parser = MarkdownParser()
    
    // SwiftData context
    private let context: ModelContext
    
    private var autoSaveTask: Task<Void, Never>?
    
    
    
    // MARK: - Init
    required init(context: ModelContext) {
        self.context = context
        load()
    }
    
    
    
    // MARK: - Auto Save
    
    // MARK: - Auto Save
    private func scheduleAutoSave() {
        autoSaveTask?.cancel()
        autoSaveTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second debounce
            guard let self else { return }
            do {
                try await self.saveSnippet()
                // Print log with current time
                let formatter = DateFormatter()
                formatter.timeStyle = .medium
                formatter.dateStyle = .short
                print("Auto-saved snippet '\(self.title)' at \(formatter.string(from: Date()))")
            } catch {
                print("Failed auto-save: \(error.localizedDescription)")
            }
        }
    }

    
    
    // MARK: - Parsing
    
    private func parseMarkdown() {
        markdownBlocks = parser.parse(content)
    }
    
    // MARK: - SwiftData CRUD
    func saveSnippet() async throws {
        if let snippet = currentSnippet {
            // Update existing snippet
            snippet.title = title
            snippet.content = content
            snippet.language = language
            snippet.createdAt = Date()
        } else {
            // Create new snippet
            let snippet = Snippet(title: title, content: content, language: language)
            context.insert(snippet)
            snippets.append(snippet)
            currentSnippet = snippet
        }
        try context.save()
    }
    
    func loadSnippet(_ snippet: Snippet) {
        self.currentSnippet = snippet
        self.title = snippet.title
        self.content = snippet.content
        self.language = snippet.language
        self.createdAt = snippet.createdAt
        parseMarkdown()
        self.title = ""
        self.content = ""
        self.language = .swift
        self.createdAt = Date()
    }
    
    func updateSnippet(_ snippet: Snippet) async throws {
        snippet.title = title
        snippet.content = content
        snippet.language = language
        snippet.createdAt = Date()
        try context.save()
        parseMarkdown()
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
