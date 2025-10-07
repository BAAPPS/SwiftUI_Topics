//
//  SettingsViewModel.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import SwiftUI
import SwiftData

@Observable
final class SettingsViewModel{
    static var shared: SettingsViewModel!

    private let context: ModelContext
    
    var settings: AppSettings
    
    init(context: ModelContext) {
        self.context = context
        if let existing = try? context.fetch(FetchDescriptor<AppSettings>()).first {
            settings = existing
        } else {
            let newSettings = AppSettings()
            context.insert(newSettings)
            settings = newSettings
            save(debugDescription: "New Settings Created: \(newSettings)")
        }
    }
    
    // MARK: - Update Methods
    
    func updateTheme(to theme: Theme){
        settings.theme = theme
        save()
    }
    
    func updateAccentColor(to color: AccentColor){
        settings.accentColor = color
        save()
    }
    
    func toggleNotifications() {
        settings.notificationsEnabled.toggle()
        save()
    }
    
    func updateFontSize(to size: Double) {
        settings.fontSize = size
        save()
    }
    
    // MARK: - Private Save Helper
    
    private func save(debugDescription: String? = nil) {
        do {
            try context.save()
            if let debugDescription = debugDescription {
                print(debugDescription)
            }
        } catch {
            print("Failed to save settings: \(error.localizedDescription)")
        }
    }
    
    
}
