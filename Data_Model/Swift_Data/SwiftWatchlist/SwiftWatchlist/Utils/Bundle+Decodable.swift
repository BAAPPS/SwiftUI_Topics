//
//  Bundle+Decodable.swift
//  SwiftWatchlist
//
//  Created by D F on 9/24/25.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T? {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            print("Failed to locate \(file) in bundle.")
            return nil
        }

        guard let data = try? Data(contentsOf: url) else {
            print("Failed to load \(file) from bundle.")
            return nil
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = DateDecoder.decodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding failed for \(file): \(error)")
            
            // Optional: print first 200 characters of JSON to check structure
            let snippet = String(data: data.prefix(200), encoding: .utf8) ?? "n/a"
            print("JSON snippet:\n\(snippet)")
            
            return nil
        }
    }
}
