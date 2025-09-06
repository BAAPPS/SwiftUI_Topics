//
//  String+Extensions.swift
//  OpenLibraryModel
//
//  Created by D F on 9/3/25.
//

import Foundation

extension String {
    private static let lowercasedWords: Set<String> = [
        "a", "an", "and", "as", "at", "but", "by",
        "for", "in", "nor", "of", "on", "or", "per",
        "so", "the", "to", "vs", "via"
    ]
    
    func titleCased() -> String {
        let words = self.lowercased().split(separator: " ")
        return words.enumerated().map {index, word in
            let strWord = String(word)
            if index == 0 || !Self.lowercasedWords.contains(strWord) {
                return strWord.capitalized
            } else {
                return strWord
            }
        }
        .joined(separator: " ")
    }
}
