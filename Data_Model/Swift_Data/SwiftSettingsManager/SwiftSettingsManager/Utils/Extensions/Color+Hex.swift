//
//  Color+Hex.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        let r, g, b: Double
        var int: UInt64 = 0
        
        Scanner(string: hex).scanHexInt64(&int)
        
        // Supports standard 6-character hex codes (RRGGBB)
        if hex.count == 6 {
            r = Double((int >> 16) & 0xFF) / 255
            g = Double((int >> 8) & 0xFF) / 255
            b = Double(int & 0xFF) / 255
        }
        else {
            // white default
            r = 1
            g = 1
            b = 1
        }
        
        self.init(red: r, green: g, blue: b)
    }
}

