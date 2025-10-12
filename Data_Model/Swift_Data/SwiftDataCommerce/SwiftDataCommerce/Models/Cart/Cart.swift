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
    var id: UUID
    var date: Date
    
    // One-to-many: each Cart has many items
    @Relationship(deleteRule: .cascade, inverse: \CartItem.cart)
    var items: [CartItem] = []
    
    var totalPrice: Double {
        items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    
    init(id: UUID = UUID(), date: Date = Date(), items: [CartItem] = []) {
        self.id = id
        self.date = date
        self.items = items
    }
}

