//
//  CollectionEntityModel.swift
//  Coverr_Model
//
//  Created by D F on 9/21/25.
//

import Foundation
import SwiftData

@Model
final class CollectionEntityModel {
    @Attribute(.unique) var id: String
    var name: String
    var title: String
    var metaTitle: String
    var collectionDescription: String
    var coverImage: String?
    var tags: [String]?
    var itemsCount:String?
    init(from hit: CollectionHitModel) {
        self.id = hit.id
        self.name = hit.name
        self.title = hit.title
        self.metaTitle = hit.metaTitle
        self.collectionDescription = hit.description
        self.tags = hit.tags
        self.itemsCount = hit.itemsCount
        self.coverImage = hit.coverImage
    }
}


extension CollectionEntityModel {
    static var example: CollectionEntityModel {
        CollectionEntityModel(from: CollectionHitModel.example)
    }
}

