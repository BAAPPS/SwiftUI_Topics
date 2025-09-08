//
//  Dates.swift
//  IGDBAPI_Model
//
//  Created by D F on 9/8/25.
//

import Foundation

struct Dates {
    static func formattedReleaseDate(from timestamp: Int?) -> String {
        guard let ts = timestamp else { return "TBA" }
        let date = Date(timeIntervalSince1970: TimeInterval(ts))
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // force UTC
        return formatter.string(from: date)
    }
}
