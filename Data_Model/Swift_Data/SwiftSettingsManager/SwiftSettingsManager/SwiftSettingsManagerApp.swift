//
//  SwiftSettingsManagerApp.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import SwiftUI
import SwiftData


@main
struct SwiftSettingsManagerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentViewProvider()
                .modelContainer(for: AppSettings.self)
        }
    }
}

struct ContentViewProvider:View{
    @Environment(\.modelContext) private var context
      var body: some View {
          ContentView(context: context)
      }
}
