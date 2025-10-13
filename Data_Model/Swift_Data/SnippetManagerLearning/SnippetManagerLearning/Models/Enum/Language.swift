//
//  Language.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/13/25.
//

import Foundation

enum Language: String, CaseIterable, Codable, Identifiable {
    case swift
    case python
    case javascript
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .swift: return "Swift (SwiftUI)"
        case .python: return "Python"
        case .javascript: return "JavaScript"
        }
    }
    
}
