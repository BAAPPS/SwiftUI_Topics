//
//  Rating.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/7/25.
//

import Foundation
import SwiftData

@Model
final class Rating {
    var rating: Double
    var count : Int
    
    init(rating: Double, count: Int) {
        self.rating = rating
        self.count = count
    }
}
