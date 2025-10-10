//
//  CartItems.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/7/25.
//

import Foundation
import SwiftData

@Model
final class CartItem {
    var quantity: Int
    
    // Each CartItem belongs to one Product
    @Relationship var product: Product
    
    // Each CartItem belongs to one Cart (inverse relationship)
    @Relationship(inverse: \Cart.items) var cart: Cart
    
    init(quantity: Int, product: Product, cart: Cart) {
        self.quantity = quantity
        self.product = product
        self.cart = cart
    }
}
