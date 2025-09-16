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
    let state: String?
    let tags: [String]?
    let publishedAt: Date?
    let downloads: Int?
    let likes: Int?
    let views: Int?
    let downloadsLastMonth: Int?
    let urls: VideoUrlsModel?
    enum CodingKeys: String, CodingKey {
        case id, title, poster, thumbnail, description, urls
        case downloads, likes, views, state, tags
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case publishedAt = "published_at"
        case downloadsLastMonth = "downloads_last_month"
    }

}


extension VideoHitsModel {
    static let example = VideoHitsModel(
        id: "IhmgzaOUQb",
        createdAt: ISO8601DateFormatter().date(from: "2018-07-09T22:48:06.165Z") ?? Date(),
        updatedAt: ISO8601DateFormatter().date(from: "2021-11-30T20:02:38.280Z") ?? Date(),
        title: "The open trunk of a white car",
        poster: "https://cdn.coverr.co/videos/coverr-the-open-trunk-of-a-white-car-4854/thumbnail?width=1920",
        thumbnail: "https://cdn.coverr.co/videos/coverr-the-open-trunk-of-a-white-car-4854/thumbnail?width=640",
        description: "Still shot of the open trunk of a white car in a car display shop.",
        state: "published",
        tags: ["white","car","vehicle","boot","suv","empty","automobile","behind","rear","modern","object","shopping","open trunk","trunk","white car"],
        publishedAt: ISO8601DateFormatter().date(from: "2018-03-05T00:00:00.000Z"),
        downloads: nil,
        likes: 0,
        views: nil,
        downloadsLastMonth: 13,
        urls: VideoUrlsModel(
            mp4: URL(string: "https://cdn.coverr.co/videos/coverr-the-open-trunk-of-a-white-car-4854/1080p.mp4")!,
            mp4_preview: URL(string: "https://cdn.coverr.co/videos/coverr-the-open-trunk-of-a-white-car-4854/360p.mp4")!,
            mp4_download: URL(string: "https://cdn.coverr.co/videos/coverr-the-open-trunk-of-a-white-car-4854/1080p.mp4?download=true")!
        )
    )
}
