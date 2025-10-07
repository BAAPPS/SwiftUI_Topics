//
//  AppSettingsSection.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import Foundation
import SwiftUI

enum AppSettingsSection: String, Codable, CaseIterable, Identifiable, Hashable {
    case display, notifications
    var id: String{rawValue}
    
    var title: String {
        switch self {
        case .display: "Display"
        case .notifications: "Notifications"
        }
    }
    
    var icon: Image {
        switch self {
        case .display: return Image(systemName: "paintbrush")
        case .notifications: return Image(systemName: "bell.fill")
        }
    }
    
    var iconColor: Color {
        switch self {
        case .display, .notifications: return .accentAqua
        }
    }
    
    var iconBackground: Color {
        switch self {
        case .display, .notifications: return .primaryIcon
        }
    }
}
