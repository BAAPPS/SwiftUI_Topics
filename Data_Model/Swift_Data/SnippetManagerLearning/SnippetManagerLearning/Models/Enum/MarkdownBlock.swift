//
//  MarkdownBlock.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/13/25.
//

import Foundation

enum MarkdownBlock{
    case header(level: Int, text: String)
    case code(language: Language?, context: String)
    case paragraph(text: String)
    case component(key: String)
}
