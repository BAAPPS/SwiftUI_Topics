//
//  CollectionModel.swift
//  Coverr_Model
//
//  Created by D F on 9/21/25.
//

import Foundation

struct CollectionModel:Codable {
    let page: Int
    let pages: Int
    let pageSize: Int
    let total: Int
    let hits: [CollectionHitModel]
    
    enum CodingKeys: String, CodingKey {
        case page, pages, total, hits
        case pageSize = "page_size"
    }
    
}

