//
//  SnippetViewModel.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/13/25.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
@Observable
final class SnippetViewModel: ModelContextInitializable {

    // MARK: - Snippet Metadata
    var title: String = "" {
        didSet { scheduleAutoSave() }
    }
    
    var language: Language = .swift {
        didSet { scheduleAutoSave() }
    }
    
    var createdAt: Date = Date()
    var placeholder: String = "Start typing..."
    
    var currentSnippet: Snippet? = nil
    var snippets: [Snippet] = []

    // MARK: - Blocks
    var blocks: [EditableBlock] = [
        EditableBlock(type: .paragraph, text: "")
    ]
    

    var markdownBlocks: [MarkdownBlock] = []


    // MARK: - SwiftData
    private let context: ModelContext

    private var autoSaveTask: Task<Void, Never>?
    private var lastChangeTime: Date?

    // MARK: - Init
    required init(context: ModelContext) {
        self.context = context
        loadSnippets()
    }

    // MARK: - Block Handling
    func switchType(for block: EditableBlock, to newType: TypingBlockType) {
        // Commit the current line first
        guard !block.text.isEmpty else {
            // If empty, just switch placeholder/type
            blocks[0].type = newType
            return
        }

        let committedBlock = block.toMarkdownBlock()
        markdownBlocks.append(committedBlock)

        // Reset single block with new type
        blocks[0] = EditableBlock(type: newType, text: "")
    }



    // MARK: - Auto Save
    private func scheduleAutoSave() {
        lastChangeTime = Date()

        autoSaveTask?.cancel()
        autoSaveTask = Task { [weak self] in
            guard let self else { return }

            try? await Task.sleep(nanoseconds: 2_000_000_000)
            guard let last = lastChangeTime, Date().timeIntervalSince(last) >= 2 else { return }

            await MainActor.run {
                // All changes are in-place, so nothing extra needed
            }

            do {
                try await self.saveSnippet()
            } catch {
                print("Failed auto-save: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Save / Reset
    func saveSnippet() async throws {
        guard let snippet = currentSnippet else { return }
        guard let block = blocks.first else { return } // safe access

        // Convert block to string manually
        let content: String
        switch block.type {
        case .header(let level):
            content = String(repeating: "#", count: level) + " " + block.text
        case .paragraph:
            content = block.text
        case .code:
            content = "```\n\(block.text)\n```"
        case .component:
            content = "[[\(block.text)]]"
        case .none:
            content = block.text
        }

        snippet.content = content
        snippet.language = language
        snippet.title = title
        snippet.createdAt = Date()
        try context.save()
    }


    func resetSnippet() {
        currentSnippet = nil
        title = ""
        language = .swift
        blocks = [EditableBlock(type: .paragraph, text: "")]
        placeholder = "Start typing..."
    }

    // MARK: - Load / Drafts
    func createDraft(context: ModelContext) {
        guard currentSnippet == nil else { return }
        let draft = Snippet(title: "", content: "", language: language)
        context.insert(draft)
        currentSnippet = draft
        snippets.append(draft)
    }

    func loadSnippet(_ snippet: Snippet) {
        currentSnippet = snippet
        title = snippet.title
        language = snippet.language
        createdAt = snippet.createdAt
        blocks = parseContentToBlocks(snippet.content)
    }

    func deleteSnippet(_ snippet: Snippet) async throws {
        context.delete(snippet)
        try context.save()
        if let idx = snippets.firstIndex(of: snippet) {
            snippets.remove(at: idx)
        }
    }

    private func loadSnippets() {
        do {
            let request = FetchDescriptor<Snippet>(sortBy: [SortDescriptor(\.createdAt, order: .forward)])
            snippets = try context.fetch(request)
        } catch {
            print("Failed to load snippets: \(error.localizedDescription)")
        }
    }

    // MARK: - Parsing Markdown to Blocks
    private func parseContentToBlocks(_ content: String) -> [EditableBlock] {
        // Simplified parser: split by double newlines, detect headers / code / component
        let lines = content.components(separatedBy: "\n\n")
        return lines.map { line in
            if line.starts(with: "#") {
                let level = line.prefix(while: { $0 == "#" }).count
                let text = line.dropFirst(level).trimmingCharacters(in: .whitespaces)
                return EditableBlock(type: .header(level: level), text: text)
            } else if line.starts(with: "```") {
                let code = line.replacingOccurrences(of: "```", with: "")
                return EditableBlock(type: .code(language: .swift), text: code)
            } else if line.starts(with: "[[") && line.hasSuffix("]]")  {
                let key = String(line.dropFirst(2).dropLast(2))
                return EditableBlock(type: .component, text: key)
            } else {
                return EditableBlock(type: .paragraph, text: line)
            }
        }
    }
}

