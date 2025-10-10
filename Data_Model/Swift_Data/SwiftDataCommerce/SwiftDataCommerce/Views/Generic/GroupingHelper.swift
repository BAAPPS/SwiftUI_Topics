//
//  GroupingHelper.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/10/25.
//

import Foundation

struct GroupingHelper {
    
    /// Groups an array of items by a given key path.
    ///
    /// - Parameters:
    ///   - items: The array of items to group.
    ///   - keyPath: The key path of the property to group by.
    /// - Returns: A dictionary where keys are the property values and values are arrays of items sharing that key.
    static func group<Item, Key: Hashable>(_ items: [Item], by keyPath: KeyPath<Item, Key>) -> [Key: [Item]] {
        Dictionary(grouping: items) { $0[keyPath: keyPath] }
    }
}
