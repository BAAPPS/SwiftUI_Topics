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
    init() {
        let container = try! ModelContainer(for: AppSettings.self)
        let context = ModelContext(container)
        SettingsViewModel.initialize(context: context)
    }
    
    var body: some Scene {
        WindowGroup {
            let sharedVM = SettingsViewModel.shared!
            
            ContentView()
                .environment(sharedVM)
                .modelContainer(for: AppSettings.self)
        }
    }
}
