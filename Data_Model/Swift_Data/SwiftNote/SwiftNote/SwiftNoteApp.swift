//
//  SwiftNoteApp.swift
//  SwiftNote
//
//  Created by D F on 9/22/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftNoteApp: App {
    var body: some Scene {
        WindowGroup {
            ContentViewProvider()
                .modelContainer(for: Note.self)
        }
    }
}


// Helper view to access the environment ModelContext and inject it into ContentView
struct ContentViewProvider: View {
    @Environment(\.modelContext) private var context
    var body: some View {
        ContentView(context: context)
    }
}
