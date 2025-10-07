//
//  AppSettings.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import Foundation
import SwiftData

@Model
final class AppSettings {
    var themeRaw:String
    var accentColorRaw: String
    var fontSize: Double
    var notificationsEnabled: Bool
    
    init(theme: Theme = .system , accentColor: AccentColor = .sky, fontSize: Double = 16.0, notificationsEnabled: Bool = false) {
        self.themeRaw = theme.rawValue
        self.accentColorRaw = accentColor.rawValue
        self.fontSize = fontSize
        self.notificationsEnabled = notificationsEnabled
    }
    
    var theme: Theme {
        get { Theme(rawValue: themeRaw) ?? .system }
        set { themeRaw = newValue.rawValue }
    }
    
    var accentColor: AccentColor {
        get { AccentColor(rawValue: accentColorRaw) ?? .sky }
        set { accentColorRaw = newValue.rawValue }
    }
}
