//
//  Array+Extension.swift
//  LocalJSONModel
//
//  Created by D F on 9/7/25.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}


// MARK: - Sorting & Deduplication Helper
extension Array where Element == EpisodesModel {
    /// Deduplicate by title and sort numerically by episode number
    func dedupAndSort() -> [EpisodesModel] {
        let unique = Array(Set(self))
        return unique.sorted { lhs, rhs in
            lhs.title.extractEpisodeNumber() < rhs.title.extractEpisodeNumber()
        }
    }
}
