//
//  GeoLocation.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/7/25.
//

import Foundation
import SwiftData

@Model
final class GeoLocation{
    var lat: String
    var long: String
    
    // Inverse relationship — each GeoLocation belongs to one Address
    @Relationship(inverse: \Address.geolocation) var address: Address?


    init(lat: String, long: String) {
        self.lat = lat
        self.long = long
    }
}
