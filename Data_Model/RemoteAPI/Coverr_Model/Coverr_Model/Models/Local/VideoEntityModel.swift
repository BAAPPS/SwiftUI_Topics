//
//  VideoEntityModel.swift
//  Coverr_Model
//
//  Created by D F on 9/19/25.
//

import Foundation
import SwiftData

@Model
final class VideoEntityModel {
    @Attribute(.unique) var id: String
    var createdAt: Date?
    var updatedAt: Date?
    var title: String
    var poster: String?
    var thumbnail: String?
    var videoDescription: String
    var state: String?
    var tags: [String]?
    var publishedAt: Date?
    var downloads: Int?
    var likes: Int?
    var views: Int?
    var downloadsLastMonth: Int?
    var urls: VideoUrlsEntityModel?
    init(from hit: VideoHitsModel) {
        self.id = hit.id
        self.createdAt = hit.createdAt
        self.updatedAt = hit.updatedAt
        self.title = hit.title
        self.poster = hit.poster
        self.thumbnail = hit.thumbnail
        self.videoDescription = hit.description
        self.state = hit.state
        self.tags = hit.tags
        self.publishedAt = hit.publishedAt
        self.downloads = hit.downloads
        self.likes = hit.likes
        self.views = hit.views
        self.downloadsLastMonth = hit.downloadsLastMonth
        self.urls = hit.urls.map{VideoUrlsEntityModel(from: $0)}
    }
}


extension VideoEntityModel {
    static var example: VideoEntityModel {
        VideoEntityModel(from: VideoHitsModel.example)
    }
}
