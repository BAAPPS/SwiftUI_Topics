//
//  Carts.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/7/25.
//

import Foundation
import SwiftData

@Model
final class Cart {
    var id: Int
    var date: Date
    
    @Relationship var user: User
    @Relationship(deleteRule: .cascade) var items: [CartItem] = []  // one-to-many

    var totalPrice: Double {
        items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }

    
    init(id: Int, date: Date, user: User, items: [CartItem] = []) {
        self.id = id
        self.date = date
        self.user = user
        self.items = items
    }
}

