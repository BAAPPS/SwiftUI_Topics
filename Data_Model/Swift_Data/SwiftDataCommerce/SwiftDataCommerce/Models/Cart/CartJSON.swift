//
//  CartJSON.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/7/25.
//

import Foundation

struct CartJSON: Codable {
    let id: Int
    let userId: Int
    let date: String
    let products: [CartProductJSON]
}

struct CartProductJSON: Codable {
    let productId: Int
    let quantity: Int
}
