//
//  ImagesModel.swift
//  HarvardArtModel
//
//  Created by D F on 9/6/25.
//

import Foundation


struct ImagesModel: Codable {
    let info: Info
    let records: [ImageModel]
    
    
    struct Info: Codable {
        let totalRecordsPerQuery: Int
        let totalRecords: Int
        let pages: Int
        let page: Int
        let next: String?
        let responseTime: String
        
        enum CodingKeys: String, CodingKey {
            case totalRecordsPerQuery = "totalrecordsperquery"
            case totalRecords = "totalrecords"
            case pages, page, next
            case responseTime = "responsetime"
        }
        
    }
}
