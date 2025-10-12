//
//  Users.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/7/25.
//

import SwiftData
import Foundation

@Model
final class User {
    var id: Int
    var email: String
    var username: String
    var phone: String
    
    var fullName: String {
        "\(name.firstname.capitalized) \(name.lastname.capitalized)"
    }
    

    @Relationship(deleteRule: .cascade, inverse: \Order.user) var orders: [Order] = []
        
    @Relationship(deleteRule: .cascade) var address: Address
    @Relationship(deleteRule: .cascade) var name: Name
    

    init(id: Int, email: String, username: String, phone: String, orders: [Order] = [], address: Address, name: Name) {
        self.id = id
        self.email = email
        self.username = username
        self.phone = phone
        self.orders = orders
        self.address = address
        self.name = name
    }
}



