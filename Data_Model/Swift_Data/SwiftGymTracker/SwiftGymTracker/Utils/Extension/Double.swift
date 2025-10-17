//
//  Double.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//

import Foundation

extension Double {
    var emoji: String {
        switch self {
        case 0.0..<500.0: return "🙂"
        case 500.0..<2000.0: return "💪"
        case 2000.0..<5000.0: return "🔥"
        default: return "🥳"
        }
    }
}
