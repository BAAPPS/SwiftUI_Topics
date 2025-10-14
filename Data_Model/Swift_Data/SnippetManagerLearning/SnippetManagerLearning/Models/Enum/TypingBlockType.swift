//
//  TypingBlockType.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/14/25.
//

import Foundation

enum TypingBlockType {
    case header(level: Int)
    case paragraph
    case code(language: Language?)
    case component
    case none
}
