//
//  VideoHitsModel.swift
//  Coverr_Model
//
//  Created by D F on 9/14/25.
//

import Foundation

struct VideoHitsModel: Codable, Identifiable, Hashable {
    let id: String
    let createdAt: Date?
    let updatedAt: Date?
    let title: String
    let poster: String?
    let thumbnail: String?
    let description: String
    let tags: [String] = []
    let publishedAt: Date?
    let downloads: Int?
    let likes: Int?
    let views: Int?
    let downloadsLastMonth: Int?
    let urls: VideoUrlsModel?
    enum CodingKeys: String, CodingKey {
        case id, title, poster, thumbnail, description, urls
        case downloads, likes, views
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case publishedAt = "published_at"
        case downloadsLastMonth = "downloads_last_month"
    }

}
