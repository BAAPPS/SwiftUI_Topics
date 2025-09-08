//
//  GamesModel.swift
//  IGDBAPI_Model
//
//  Created by D F on 9/8/25.
//

import Foundation

struct GamesModel: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let summary: String?
    let url: String
    let cover: Cover?
    let genres: [Genres]?
    let firstReleaseDate: Int?
    
    struct Cover: Codable, Identifiable, Hashable {
        let id: Int
        let url: String
    }
    
    struct Genres: Codable, Identifiable, Hashable {
        let id: Int
        let name: String
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, summary, url, cover, genres
        case firstReleaseDate = "first_release_date"
    }
    
    static let example = GamesModel(
        id: 1,
        name: "Example Game",
        summary: "This is an example game used for SwiftUI previews.",
        url: "https://www.igdb.com/games/shadowless--1",
        cover: Cover(id: 101, url: "//images.igdb.com/igdb/image/upload/t_thumb/co3vbi.jpg"),
        genres: [Genres(id: 1, name: "Action")],
        firstReleaseDate: 1923955200
    )

}
