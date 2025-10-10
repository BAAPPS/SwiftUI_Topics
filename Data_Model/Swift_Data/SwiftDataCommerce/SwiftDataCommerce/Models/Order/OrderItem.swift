//
//  OrderItem.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/9/25.
//

import Foundation
import SwiftData

@Model
final class OrderItem {
    var quantity: Int
    @Relationship var product: Product
    @Relationship var order: Order
    
    init(quantity: Int, product: Product, order: Order) {
        self.quantity = quantity
        self.product = product
        self.order = order
    }
}
