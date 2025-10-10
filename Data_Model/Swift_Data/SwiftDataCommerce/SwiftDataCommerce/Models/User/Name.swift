//
//  Name.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/7/25.
//

import Foundation
import SwiftData

@Model
final class Name{
    var firstname: String
    var lastname: String

    init(firstname: String, lastname: String) {
        self.firstname = firstname
        self.lastname = lastname
    }
}

