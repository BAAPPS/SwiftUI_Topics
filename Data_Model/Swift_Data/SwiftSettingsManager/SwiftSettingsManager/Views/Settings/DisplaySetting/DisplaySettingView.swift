//
//  DisplaySettingView.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import SwiftUI
import SwiftData

struct DisplaySettingView: View {
    @Environment(SettingsViewModel.self) var settingsVM
    var body: some View {
            ThemedView {
                NavBarView(title: "Display", showBackButton: true) {
                VStack {
                    Text("Appearance".uppercased())
                        .font(.system(size: settingsVM.settings.fontSize, weight: .bold))
                        .frame(maxWidth:.infinity, alignment: .topLeading)
                    
                    Section{
                        ThemeSelectorView()
                        AccentSelectorView()
                        TextSizeSelectorView()
                        
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: AppSettings.self)
    let context = ModelContext(container)
    
    
    SettingsViewModel.initialize(context: context)
    
    return NavigationStack {
        DisplaySettingView()
            .environment(SettingsViewModel.shared)
            .environment(\.modelContext, context)
    }
}
