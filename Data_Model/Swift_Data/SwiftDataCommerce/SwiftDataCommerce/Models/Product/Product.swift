//
//  Products.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/7/25.
//

import Foundation
import SwiftData

@Model
final class Product {
    var id: Int
    var productDescription: String
    var category: String
    var image: String
    var price: Double
    var title: String
    
    @Relationship var rating: Rating?
    @Relationship var cartItems: [CartItem]?
    @Relationship var orderItems: [OrderItem]?
    
    init(id: Int, productDescription: String, category: String, image: String, price: Double, title: String, rating: Rating? = nil, cartItems: [CartItem]? = nil, orderItems: [OrderItem]? = nil) {
        self.id = id
        self.productDescription = productDescription
        self.category = category
        self.image = image
        self.price = price
        self.title = title
        self.rating = rating
        self.cartItems = cartItems
        self.orderItems = orderItems
    }
    
}
