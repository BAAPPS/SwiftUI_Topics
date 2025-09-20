//
//  Coverr_ModelApp.swift
//  Coverr_Model
//
//  Created by D F on 9/12/25.
//

import SwiftUI
import SwiftData

@main
struct Coverr_ModelApp: App {
    @State private var networkMonitor = NetworkMonitorModel()
    var body: some Scene {
        WindowGroup {
            ContentViewProvider()
                .modelContainer(for: VideoEntityModel.self)
                // Inject the production network monitor wrapped in the holder
                .environment(NetworkMonitorHolder(networkMonitor))
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
