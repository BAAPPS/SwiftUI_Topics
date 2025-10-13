//
//  ModelContextInitializable.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/13/25.
//

import Foundation
import SwiftData

@MainActor
protocol ModelContextInitializable {
    
    init(context: ModelContext)
    func load()
}


extension ModelContextInitializable {
    func load() {}
}
