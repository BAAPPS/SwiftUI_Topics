//
//  SwiftWatchlistApp.swift
//  SwiftWatchlist
//
//  Created by D F on 9/23/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftWatchlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentViewProvider()
                .modelContainer(for: Movie.self)
        }
    }
}

struct ContentViewProvider: View {
    @Environment(\.modelContext) private var context
    var body: some View {
        ContentView(context: context)
    }
}
