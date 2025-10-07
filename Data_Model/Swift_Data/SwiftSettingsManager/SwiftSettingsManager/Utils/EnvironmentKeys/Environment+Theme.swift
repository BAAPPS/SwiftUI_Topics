//
//  Environment+Theme.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import Foundation
import SwiftUI


// MARK: - Environment Keys
struct AppThemeKey: EnvironmentKey {
    static let defaultValue: Theme = .system // fallback
}

struct AppAccentColorKey: EnvironmentKey {
    static let defaultValue: AccentColor = .sky
}

// MARK: - Environment Values

extension EnvironmentValues {
    var appAccentColor: AccentColor {
        get { self[AppAccentColorKey.self] }
        set { self[AppAccentColorKey.self] = newValue }
    }
    
    var appTheme: Theme {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}
