//
//  TypingBlockType.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/14/25.
//

import Foundation

enum TypingBlockType: Equatable {
    case header(level: Int)
    case paragraph
    case code(language: Language?)
    case component
    case none

    var displayName: String {
        switch self {
        case .header(let level): return "Header \(level)"
        case .paragraph: return "Paragraph"
        case .code: return "Code"
        case .component: return "Component"
        case .none: return "None"
        }
    }
}
