//
//  ImageModel.swift
//  HarvardArtModel
//
//  Created by D F on 9/6/25.
//

import Foundation


struct ImageModel: Codable, Identifiable, Hashable {
    var id: Int {
        idsid
    }
    let idsid: Int
    let date: Date?
    let createdDate: Date?
    let lastUpdated: Date?
    let format: String?
    let copyright: String?
    let caption: String?
    let baseImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case idsid, date, format, copyright, caption
        case createdDate = "createdate"
        case baseImageURL = "baseimageurl"
        case lastUpdated = "lastupdate"
    }
}
