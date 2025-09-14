//
//  VideosModel.swift
//  Coverr_Model
//
//  Created by D F on 9/14/25.
//

import Foundation

struct VideosModel: Codable {
    let page: Int
    let pages: Int
    let pageSize: Int
    let total: Int
    let hits: [VideoHitsModel]
    
    enum CodingKeys: String, CodingKey {
        case page, pages, total, hits
        case pageSize = "page_size"
    }
    
}
