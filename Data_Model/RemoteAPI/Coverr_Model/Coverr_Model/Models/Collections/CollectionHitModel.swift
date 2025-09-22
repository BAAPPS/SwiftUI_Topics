//
//  CollectionVideoModel.swift
//  Coverr_Model
//
//  Created by D F on 9/21/25.
//

import Foundation

struct CollectionHitModel: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let title: String
    let metaTitle: String
    let description: String
    let coverImage: String?
    let tags: [String]?
    let itemsCount:String?
    enum CodingKeys: String, CodingKey {
        case id, title, name, description, tags, itemsCount
        case coverImage = "cover_image"
        case metaTitle = "meta_title"
    }
    
}


extension CollectionHitModel {
    static let example = CollectionHitModel(
        id: "3uLzPNgIGD",
        name:"Skate Culture",
        title: "The open trunk of a white car",
        metaTitle: "Free Skate Culture Stock Video Footage - Royalty Free Video Download | Coverr",
        description:  "A collection dedicated to skaters all around the world, celebrating its debut in the 2020 olympics. Let's face it, skaters are cool so who doesn't want a skating video for free? Right? right.",
        coverImage: "https://cdn.coverr.co/videos/coverr-a-skateboarder-skating-up-and-down-a-mini-ramp-2254/thumbnail?width=640",
        tags: [
            "skateboard",
            "skate",
            "skater"
        ],
        itemsCount: "34"
    )
    
    init(from entity: CollectionEntityModel) {
        self.id = entity.id
        self.name = entity.name
        self.title = entity.title
        self.metaTitle = entity.metaTitle
        self.description = entity.collectionDescription
        self.tags = entity.tags
        self.itemsCount = entity.itemsCount
        self.coverImage = entity.coverImage
    }
}
