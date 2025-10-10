//
//  Bundle+Decodable.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/9/25.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> Result<T, Error> {
        // Locate file in bundle
        guard let url = self.url(forResource: file, withExtension: nil) else {
            return .failure(NSError(domain: "BundleDecode", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to locate \(file) in bundle."]))
        }
        
        // Load data
        guard let data = try? Data(contentsOf: url) else {
            return .failure(NSError(domain: "BundleDecode", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to load \(file) from bundle."]))
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = DateDecoder.decodingStrategy
        
        // Decode
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return .success(decoded)
        } catch {
            let snippet = String(data: data.prefix(200), encoding: .utf8) ?? "N/A"
            print("Decoding failed for \(file): \(error)")
            print("JSON ERROR SNIPPET:\n\(snippet)")
            return .failure(error)
        }
    }
}
