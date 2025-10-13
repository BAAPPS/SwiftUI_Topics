//
//  SnippetManagerLearningApp.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/13/25.
//

import SwiftUI
import SwiftData

@main
struct SnippetManagerLearningApp: App {
    let container: ModelContainer
    
    init() {
        do {
#if DEBUG
            // --- DEV MODE (persistent for learning) ---
            let config = ModelConfiguration(isStoredInMemoryOnly: false)
#else
            // --- PROD MODE ---
            print("Running PROD mode (persistent default.store)")
            let config = ModelConfiguration(isStoredInMemoryOnly: false)
#endif
            
            // Configure container
            container = try ModelContainer(
                for: Snippet.self,
                configurations: config
            )
            
        } catch {
            fatalError("Failed to create SwiftData container: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            let context = ModelContext(container)
            ContentView(context: context)
                .environment(\.modelContext, context)
        }
    }
}
