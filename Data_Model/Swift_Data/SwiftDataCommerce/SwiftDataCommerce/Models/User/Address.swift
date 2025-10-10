//
//  Address.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/7/25.
//

import Foundation
import SwiftData

@Model
final class Address {
    var city: String
    var street: String
    var number: Int
    var zipcode: String
    
    var formattedAddress: String {
        "\(street) \(number), \(city), \(zipcode)"
    }

    
    @Relationship(deleteRule: .cascade) var geolocation: GeoLocation
    @Relationship(inverse: \User.address) var user: User?
    

    init(city: String, street: String, number: Int, zipcode: String, geolocation: GeoLocation) {
        self.city = city
        self.street = street
        self.number = number
        self.zipcode = zipcode
        self.geolocation = geolocation
    }
}
