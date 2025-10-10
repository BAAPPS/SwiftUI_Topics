//
//  ProductJSON.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/7/25.
//

import Foundation

struct ProductJSON: Codable {
    let id: Int
    let title: String
    let price: Double
    let productDescription: String
    let category: String
    let image: String
    let rating: RatingJSON

    private enum CodingKeys: String, CodingKey {
        case id, title, price, category, image, rating
        case productDescription = "description"
    }
}

struct RatingJSON: Codable {
    let rate: Double
    let count: Int
}
