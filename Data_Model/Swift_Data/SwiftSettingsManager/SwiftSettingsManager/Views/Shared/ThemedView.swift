//
//  ThemeView.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import SwiftUI
import SwiftData

struct ThemedView<Content: View>: View {
    @Environment(SettingsViewModel.self) var settingsVM
    let content: () -> Content

    var body: some View {
        ZStack {
            settingsVM.settings.theme.backgroundColor
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.4), value: settingsVM.settings.theme)
                         
            content()
                .foregroundColor(settingsVM.settings.theme.textColor)
                .accentColor(settingsVM.settings.accentColor.color)
                .animation(.easeInOut(duration: 0.4), value: settingsVM.settings.theme)
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: AppSettings.self)
    let context = ModelContext(container)
    

    SettingsViewModel.initialize(context: context)
    
    return ThemedView {
        VStack {
            Text("Hello World")
            Button("Press Me") {}
        }
    }
    .environment(SettingsViewModel.shared)
    .environment(\.modelContext, context)
}
