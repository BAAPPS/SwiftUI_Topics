//
//  ModelContextInitializable.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/10/25.
//

import Foundation
import SwiftData

protocol ModelContextInitializable {
    init(context: ModelContext)
    func load()
}


extension ModelContextInitializable {
    func load() {}
}
