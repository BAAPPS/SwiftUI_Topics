//
//  ModelContextInitializable.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//

import Foundation
import SwiftData

@MainActor
protocol ModelContextInitializable {
    associatedtype ModelType: PersistentModel
    var context: ModelContext { get }
    var items: [ModelType] { get set }
    init(context: ModelContext)
    func load()
}

extension ModelContextInitializable {
    func load(){}
}
