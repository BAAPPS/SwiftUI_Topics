//
//  Hex+Colors.swift
//  NewsAPI_Model
//
//  Created by D F on 9/12/25.
//

import SwiftUI

extension Color {
    init(hex:String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        
        Scanner(string: hex).scanHexInt64(&int)
        var r, g , b: Double
        
        if hex.count == 6 {
            r = Double((int >> 16) & 0xFF) / 255
            g = Double((int >> 8) & 0xFF) / 255
            b = Double(int & 0xFF) / 255
        }
        else {
            r  = 1
            g = 1
            b  = 1
        }
        self.init(red: r , green: g , blue: b)
    }
    
}
