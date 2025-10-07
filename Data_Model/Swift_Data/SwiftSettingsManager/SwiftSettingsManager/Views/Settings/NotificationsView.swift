//
//  NotificationsView.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import SwiftUI
import SwiftData

struct NotificationsView: View {
    @Environment(SettingsViewModel.self) var settingsVM
    
    var body: some View {
            ThemedView {
                NavBarView(title:"Notifications", showBackButton: true) {
                VStack(spacing: 20) {
                    HStack {
                        Text("Enable Notifications")
                            .font(.system(size: settingsVM.settings.fontSize))
                            .accessibilityHidden(true)
                        Spacer()
                        Toggle("", isOn: Binding(
                            get: { settingsVM.settings.notificationsEnabled },
                            set: { settingsVM.updateNotifications(to: $0) }
                        ))
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: settingsVM.settings.accentColor.color))
                        .accessibilityLabel("Enable Notifications")
                        .accessibilityValue(settingsVM.settings.notificationsEnabled ? "On" : "Off")
                        .accessibilityHint("Turn notifications on or off")
                    }
                    .padding()
                    .background(settingsVM.settings.theme == .dark ? Color.gray.opacity(0.2) : Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    Text("You will receive alerts and updates from this app when notifications are enabled.")
                        .font(.system(size: settingsVM.settings.fontSize - 2))
                        .foregroundColor(settingsVM.settings.theme.textColor.opacity(0.8))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityLabel("Notification details")
                        .accessibilityHint("Explains that enabling notifications allows the app to send alerts and updates")
                    
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
        NotificationsView()
            .environment(SettingsViewModel.shared)
            .environment(\.modelContext, context)
    }
}
