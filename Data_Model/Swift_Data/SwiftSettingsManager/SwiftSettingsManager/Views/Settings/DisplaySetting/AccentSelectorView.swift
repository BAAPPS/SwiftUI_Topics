//
//  AccentSelectorView.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import SwiftUI
import SwiftData

struct AccentSelectorView: View {
    @Environment(SettingsViewModel.self) var settingsVM
    var body: some View {
        VStack {
            Text("Accent Color")
                .font(.system(size: settingsVM.settings.fontSize))
                .accessibilityAddTraits(.isHeader)
            
            HStack(spacing: 3) {
                ForEach(AccentColor.allCases, id: \.self) { color in
                    Button {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            settingsVM.updateAccentColor(to: color)
                        }
                    } label: {
                        Text(color.rawValue.capitalized)
                            .font(.system(size: settingsVM.settings.fontSize))
                            .foregroundColor(settingsVM.settings.accentColor == color ? .white : settingsVM.settings.theme.textColor)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                    }
                    .background(
                        settingsVM.settings.accentColor == color ?
                        color.color : Color.clear
                    )
                    .accessibilityLabel("\(color.rawValue.capitalized) accent color")
                    .accessibilityValue(settingsVM.settings.accentColor == color ? "Selected" : "Not selected")
                    .accessibilityAddTraits(settingsVM.settings.accentColor == color ? [.isSelected, .isButton] : .isButton)
                    .accessibilityHint("Tap to select this accent color")
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
            AccentSelectorView()
                .padding()
        }
        .environment(SettingsViewModel.shared)
        .environment(\.modelContext, context)
    }
}
