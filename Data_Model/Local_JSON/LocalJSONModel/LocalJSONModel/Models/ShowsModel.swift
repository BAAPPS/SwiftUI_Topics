//
//  ShowsModel.swift
//  LocalJSONModel
//
//  Created by D F on 9/2/25.
//

import Foundation

struct ShowsModel: Codable, Identifiable, Hashable {
    let schedule: String
    let title: String
    let year: String
    let subtitle: String
    let episodes: [EpisodesModel]
    let thumbImageUrl: String
    let cast: [String]
    let description: String
    let genres: [String]
    let bannerImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case schedule
        case title
        case year
        case subtitle
        case episodes
        case thumbImageUrl = "thumb_image_url"
        case cast
        case description
        case genres
        case bannerImageUrl = "banner_image_url"
    }
    
    
    // Create a unique id from multiple fields
    var id: String {
        "\(title)-\(year)-\(subtitle)"
    }
    
    static let allShows: [ShowsModel] = Bundle.main.decode("tvb_shows.json")
    static let example = allShows[0]

}
