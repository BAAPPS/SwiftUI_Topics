//
//  MarkdownParser.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/13/25.
//

import Foundation


struct MarkdownParser {
    func parse(_ text: String) -> [MarkdownBlock] {
        var blocks: [MarkdownBlock] = []
        var codeBuffer: [String] = []
        var isCodeBlock: Bool = false
        var codeLang:Language? = nil
        
        for line in text.components(separatedBy: "\n") {
            if line.hasPrefix("```"){
                if isCodeBlock{
                    blocks.append(.code(language: codeLang, context: codeBuffer.joined(separator: "\n")))
                    codeBuffer.removeAll()
                    isCodeBlock = false
                    codeLang = nil
                }else {
                    let langStr = String(line.dropFirst(3).trimmingCharacters(in: .whitespaces).lowercased())
                    codeLang = Language(rawValue: langStr)
                    isCodeBlock = true
                }
                
                continue
            }
            
            if isCodeBlock {
                codeBuffer.append(line)
                continue
            }
            
            if line.hasPrefix("###") {
                blocks.append(.header(level: 3, text: String(line.dropFirst(3))))
            }
            else if line.hasPrefix("## ") {
                blocks.append(.header(level: 2, text: String(line.dropFirst(3))))
            }
            
            else if line.hasPrefix("# ") {
                blocks.append(.header(level: 1, text: String(line.dropFirst(2))))
            }
            else if line.hasPrefix("[[") && line.hasSuffix("]]") {
                let key = String(line.dropFirst(2).dropLast(2))
                blocks.append(.component(key: key))
            }
            else {
                blocks.append(.paragraph(text: line))
            }
        }
        
        
        return blocks
        
    }
}
