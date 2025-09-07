//
//  DateDecoder.swift
//  HarvardArtModel
//
//  Created by D F on 9/7/25.
//

import Foundation

enum DateDecoder {
    
    static let plainFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = TimeZone(secondsFromGMT: 0)
        return df
    }()
    
    
    static let isoFormatterFractional: ISO8601DateFormatter = {
        let df = ISO8601DateFormatter()
        df.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return df
    }()
    
    static let isoFormatter: ISO8601DateFormatter = {
        let df = ISO8601DateFormatter()
        df.formatOptions = [.withInternetDateTime]
        return df
    }()
    
    static let decodingStrategy: JSONDecoder.DateDecodingStrategy = .custom { decoder in
        let container = try decoder.singleValueContainer()
        let dateStr = try container.decode(String.self)
               
        
        if let date = plainFormatter.date(from: dateStr) { return date }
        if let date = isoFormatterFractional.date(from: dateStr) { return date }
        if let date = isoFormatter.date(from: dateStr) { return date }
        
        
        throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid date format: \(dateStr)"
        )
    }
}

