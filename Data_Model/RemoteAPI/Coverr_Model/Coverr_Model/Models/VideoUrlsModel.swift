//
//  VideoUrlsModel.swift
//  Coverr_Model
//
//  Created by D F on 9/14/25.
//

import Foundation


struct VideoUrlsModel: Codable, Hashable {
    let mp4: URL
    let mp4_preview: URL
    let mp4_download: URL
}


extension VideoUrlsModel {
    init(from entity: VideoUrlsEntityModel) {
        self.mp4 = entity.mp4
        self.mp4_preview = entity.mp4_preview
        self.mp4_download = entity.mp4_download
    }
}
