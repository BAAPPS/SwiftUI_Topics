//
//  ThemeSelectorView.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import SwiftUI
import SwiftData

struct ThemeSelectorView: View {
    @Environment(SettingsViewModel.self) var settingsVM
    var body: some View {
        VStack{
            Text("Theme")
                .font(.system(size: settingsVM.settings.fontSize))
                .accessibilityAddTraits(.isHeader)
            
            HStack(spacing: 3) {
                ForEach(Theme.allCases, id: \.self) { theme in
                    Button {
                        settingsVM.updateTheme(to: theme)
                    } label: {
                        Text(theme.rawValue.capitalized)
                            .font(.system(size: settingsVM.settings.fontSize))
                            .foregroundColor(settingsVM.settings.theme == theme ? .white : settingsVM.settings.theme.textColor)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                    }
                    .background(settingsVM.settings.theme == theme ? settingsVM.settings.accentColor.color : Color.clear)
                    .accessibilityLabel("\(theme.rawValue.capitalized) theme")
                    .accessibilityValue(settingsVM.settings.theme == theme ? "Selected" : "Not selected")
                    .accessibilityAddTraits(settingsVM.settings.theme == theme ? [.isSelected, .isButton] : .isButton)
                    .accessibilityHint("Tap to select this theme")
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(settingsVM.settings.accentColor.color))
            
            
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    let container = try! ModelContainer(for: AppSettings.self)
    let context = ModelContext(container)
    
    
    SettingsViewModel.initialize(context: context)
    
    return NavigationStack {
        ThemedView {
            ThemeSelectorView()
                .padding()
        }
        .environment(SettingsViewModel.shared)
        .environment(\.modelContext, context)
    }
}
