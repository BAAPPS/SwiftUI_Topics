//
//  Order.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/9/25.
//

import Foundation
import SwiftData

@Model
final class Order {
    var id: Int
    var date: Date
    
    @Relationship var user: User
    @Relationship(deleteRule: .cascade) var items: [OrderItem] = []
    init(id: Int, date: Date = .now, user: User, items: [OrderItem]) {
        self.id = id
        self.date = date
        self.user = user
        self.items = items
    }
}
