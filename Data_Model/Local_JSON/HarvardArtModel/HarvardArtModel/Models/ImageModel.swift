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
    let date: Date
    let format: String
    let copyright: String
    let caption: String?
    let createdDate: Date
    
    enum CodingKeys: String, CodingKey {
        case idsid, date, format, copyright, caption
        case createdDate = "createdate"
    }
}
