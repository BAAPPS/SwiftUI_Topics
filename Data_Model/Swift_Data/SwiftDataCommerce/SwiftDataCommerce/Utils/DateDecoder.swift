//
//  DateDecoder.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/9/25.
//

import Foundation


enum DateDecoder {
    
    // ISO8601 formatter for plain dates without fractional seconds (e.g., 2025-07-18T00:00:00Z)
    static let isoFormatterPlain:ISO8601DateFormatter = {
        let df = ISO8601DateFormatter()
        df.formatOptions = [.withInternetDateTime]
        return df
    }()
    
    static let decodingStrategy: JSONDecoder.DateDecodingStrategy = .custom({ decoder in
        let container = try decoder.singleValueContainer()
        let dateString =  try container.decode(String.self)
        
        if let date = isoFormatterPlain.date(from: dateString) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(dateString)")
    })
}
