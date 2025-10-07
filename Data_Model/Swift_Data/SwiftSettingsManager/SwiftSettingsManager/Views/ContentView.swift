//
//  ContentView.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Environment(SettingsViewModel.self) var settingsVM
    
    
    var body: some View {
        NavigationStack {
            AppSettingsView()
                .environment(SettingsViewModel.shared)
        }
        .accentColor(settingsVM.settings.accentColor.color)
        .environment(\.appTheme, settingsVM.settings.theme)
        .environment(\.appAccentColor, settingsVM.settings.accentColor)
    }
}


#Preview {
    let container = try! ModelContainer(for: AppSettings.self)
    let context = ModelContext(container)
    
    // Initialize singleton first
    SettingsViewModel.initialize(context: context)
    
    return ContentView()
        .environment(SettingsViewModel.shared) // inject singleton
        .environment(\.modelContext, context) // // inject the SwiftData context
}
