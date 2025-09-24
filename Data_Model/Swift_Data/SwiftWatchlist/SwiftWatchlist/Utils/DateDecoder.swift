//
//  DateDecoder.swift
//  SwiftWatchlist
//
//  Created by D F on 9/24/25.
//

import Foundation

enum DateDecoder {
    // ISO8601 formatter for dates with fractional seconds (e.g., 2025-07-18T00:00:00.123Z)
    static let isoFormatterFractional: ISO8601DateFormatter = {
        let df = ISO8601DateFormatter()
        df.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return df
    }()
    
    // ISO8601 formatter for plain dates without fractional seconds (e.g., 2025-07-18T00:00:00Z)
    static let isoFormatterPlain: ISO8601DateFormatter = {
        let df = ISO8601DateFormatter()
        df.formatOptions = [.withInternetDateTime]
        return df
    }()
    
    // Custom decoding strategy to handle both formats
    static let decodingStrategy: JSONDecoder.DateDecodingStrategy = .custom({ decoder in
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        
        // First try fractional seconds
        if let date = isoFormatterFractional.date(from: dateString) {
            return date
        }
        // Then try plain ISO8601
        if let date = isoFormatterPlain.date(from: dateString) {
            return date
        }
        
        // If neither works, throw a decoding error
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(dateString)")
    })
}
