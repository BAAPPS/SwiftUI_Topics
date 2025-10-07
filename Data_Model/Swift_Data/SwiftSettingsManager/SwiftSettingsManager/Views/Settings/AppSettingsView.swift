//
//  AppSettingsView.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import SwiftUI
import SwiftData

struct AppSettingsView: View {
    @Environment(SettingsViewModel.self) var settingsVM
    var body: some View {
            ThemedView {
                NavBarView(title:"Settings") {
                List(AppSettingsSection.allCases) { section in
                    NavigationLink(value: section) {
                        HStack {
                            section.icon
                                .foregroundColor(section.iconColor)
                                .padding(5)
                                .background(section.iconBackground)
                                .cornerRadius(10)
                            
                            Text(section.title)
                                .font(.system(size: 18, weight: .medium))
                        }
                        .padding(.vertical, 2)
                    }
                    .listRowBackground(settingsVM.settings.theme.secondaryBackgroundColor)
                    
                }
                .background(Color.clear)
                .scrollContentBackground(.hidden)
                .navigationDestination(for: AppSettingsSection.self) { section in
                    switch section {
                    case .display:
                        DisplaySettingView()
                            .environment(SettingsViewModel.shared)
                    case .notifications:
                        NotificationsView()
                            .environment(SettingsViewModel.shared)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: AppSettings.self)
    let context = ModelContext(container)
    
    
    SettingsViewModel.initialize(context: context)
    
    return NavigationStack {
        AppSettingsView()
            .environment(SettingsViewModel.shared)
            .environment(\.modelContext, context)
    }
}
