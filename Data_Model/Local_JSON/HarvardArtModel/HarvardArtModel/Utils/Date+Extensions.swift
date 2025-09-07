//
//  Date+Extensions.swift
//  HarvardArtModel
//
//  Created by D F on 9/7/25.
//

import Foundation

extension Date {
    
    /// Returns just the 4-digit year (e.g., "1985")
    func formattedYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: self)
    }
    
    /// Returns a medium style date (e.g., "Sep 7, 2025")
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
    
    /// Returns a long style date (e.g., "September 7, 2025")
    func formattedLongDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: self)
    }
}
