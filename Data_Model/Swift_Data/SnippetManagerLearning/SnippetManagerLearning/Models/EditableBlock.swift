//
//  EditableBlock.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/14/25.
//

import Foundation

struct EditableBlock: Identifiable, Hashable {
    let id = UUID()
    var type: TypingBlockType
    var text: String

    static func == (lhs: EditableBlock, rhs: EditableBlock) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func toMarkdownBlock() -> MarkdownBlock {
        switch type {
        case .header(let level): return .header(level: level, text: text)
        case .paragraph: return .paragraph(text: text)
        case .code(let lang): return .code(language: lang, context: text)
        case .component: return .component(key: text)
        case .none: return .paragraph(text: text)
        }
    }
}
