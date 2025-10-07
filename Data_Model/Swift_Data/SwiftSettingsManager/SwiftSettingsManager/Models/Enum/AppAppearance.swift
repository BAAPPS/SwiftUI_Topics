//
//  Theme.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import Foundation
import SwiftUI

// MARK: - Theme Enum
enum Theme: String, CaseIterable, Codable, Identifiable {
    case system, dark, light
    var id: String {rawValue}
    
    var backgroundColor: Color {
        switch self {
        case .dark: return .primaryDark
        case .light: return .primaryLight
        case .system: return Color(uiColor: .systemBackground)
        }
    }
    
    var textColor: Color {
        switch self {
        case .dark: return .textDark
        case .light: return .textLight
        case .system: return Color(uiColor: .label)
        }
    }
}


// MARK: - Accent Color Enum
enum AccentColor: String, CaseIterable, Codable, Identifiable {
    case sky, aqua
    
    var id: String { rawValue }
    
    // Return the Color from your extension
    var color: Color {
        switch self {
        case .sky: return .accentSky
        case .aqua: return .accentAqua
        }
    }
    
    // Display name for pickers
    var displayName: String {
        switch self {
        case .sky: return "Sky"
        case .aqua: return "Aqua"
        }
    }
}
