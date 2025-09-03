//
//  EpisodesModel.swift
//  LocalJSONModel
//
//  Created by D F on 9/2/25.
//

import Foundation

struct EpisodesModel: Codable, Identifiable, Hashable {
    let title : String
    let url: String
    let thumbnail_url: String
    
    var id: String {
        "\(title)-\(url)"
    }
}
