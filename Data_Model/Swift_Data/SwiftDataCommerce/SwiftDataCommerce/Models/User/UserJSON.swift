//
//  UserJSON.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/7/25.
//

import Foundation

struct UserJSON: Codable {
    let id: Int
    let email: String
    let username: String
    let phone: String
    let address: AddressJSON
    let name: NameJSON
}

struct AddressJSON: Codable {
    let city: String
    let street: String
    let number: Int
    let zipcode: String
    let geolocation: GeoJSON
}

struct GeoJSON: Codable {
    let lat: String
    let long: String
}

struct NameJSON: Codable {
    let firstname: String
    let lastname: String
}
