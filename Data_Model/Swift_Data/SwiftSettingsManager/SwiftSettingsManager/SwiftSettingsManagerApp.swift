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
            ContentView()
                .modelContainer(for: AppSettings.self)
        }
    }
}

