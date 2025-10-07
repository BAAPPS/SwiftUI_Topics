//
//  TextSizeSelectorView.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import SwiftUI
import SwiftData

struct TextSizeSelectorView: View {
    @Environment(SettingsViewModel.self) var settingsVM
    var body: some View {
        VStack{
            Text("Text Size")
                .font(.system(size: settingsVM.settings.fontSize, weight: .semibold))
                .accessibilityAddTraits(.isHeader)
            VStack{
                HStack {
                    Text("A") // small
                        .font(.system(size: 12))
                    Slider(
                        value: Binding(
                            get: { settingsVM.settings.fontSize },
                            set: { settingsVM.updateFontSize(to: $0) }
                        ),
                        in: 12...24, // font size range
                        step: 1
                    )
                    .accessibilityLabel("Text Size")
                    .accessibilityValue("\(Int(settingsVM.settings.fontSize)) points")
                    .accessibilityAdjustableAction { direction in
                        switch direction {
                        case .increment:
                            let newValue = min(settingsVM.settings.fontSize + 1, 24)
                            settingsVM.updateFontSize(to: newValue)
                        case .decrement:
                            let newValue = max(settingsVM.settings.fontSize - 1, 12)
                            settingsVM.updateFontSize(to: newValue)
                        default: break
                        }
                    }
                    
                    Text("A") // large
                        .font(.system(size: 24))
                }
                // Moving preview
                GeometryReader { geo in
                    let min = 12.0
                    let max = 24.0
                    let fraction = (settingsVM.settings.fontSize - min) / (max - min)
                    let sliderWidth = geo.size.width - 40 // padding for thumb edges
                    let xPos = fraction * sliderWidth
                    
                    Text("\(Int(settingsVM.settings.fontSize)) pt")
                        .font(.system(size: settingsVM.settings.fontSize))
                        .foregroundColor(settingsVM.settings.theme.textColor)
                        .offset(x: xPos)
                        .accessibilityHidden(true)
                }
                .frame(height: 20)
            }
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
            TextSizeSelectorView()
                .padding()
        }
        .environment(SettingsViewModel.shared)
        .environment(\.modelContext, context)
    }
}
