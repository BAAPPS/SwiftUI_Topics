//
//  NavbarView.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import SwiftUI
import SwiftData

import SwiftUI
import SwiftData

struct NavBarView<Content: View>: View {
    @Environment(SettingsViewModel.self) var settingsVM
    @Environment(\.dismiss) private var dismiss
    let title: String
    let showBackButton: Bool
    let content: Content
    
    init(
        title: String,
        showBackButton: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.showBackButton = showBackButton
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Custom NavBar
            ZStack {
                Text(title)
                    .font(.system(size: settingsVM.settings.fontSize, weight: .bold))
                    .foregroundColor(settingsVM.settings.theme.textColor)
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityLabel("\(title) screen header")

                HStack {
                    if showBackButton {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(settingsVM.settings.accentColor.color)
                        }
                        .accessibilityLabel("Back")
                    }
                    Spacer()
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            .padding(.bottom, 8)
            .background(settingsVM.settings.theme.backgroundColor)
            .overlay(
                Divider()
                    .background(settingsVM.settings.accentColor.color),
                alignment: .bottom
            )
            
            // MARK: - Main Content
            content
                .padding()
                .background(settingsVM.settings.theme.backgroundColor)
                .accentColor(settingsVM.settings.accentColor.color)
        }
        .navigationBarHidden(true) 
    }
}



#Preview {
    let container = try! ModelContainer(for: AppSettings.self)
    let context = ModelContext(container)
    
    
    SettingsViewModel.initialize(context: context)
    
    return ThemedView {
        NavBarView(title: "Preview Title") {
            VStack(spacing: 12) {
                Text("This is inside the NavBarView.")
                Button("Sample Button") {}
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    .environment(SettingsViewModel.shared)
    .environment(\.modelContext, context)
}
