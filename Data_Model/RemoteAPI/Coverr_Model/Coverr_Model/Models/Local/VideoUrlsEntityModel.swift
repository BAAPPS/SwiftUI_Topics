//
//  VideoUrlsEntityModel.swift
//  Coverr_Model
//
//  Created by D F on 9/19/25.
//

import Foundation
import SwiftData

@Model
final class VideoUrlsEntityModel{
    var mp4: URL
    var mp4_preview: URL
    var mp4_download: URL
    
    init(from model: VideoUrlsModel) {
        self.mp4 = model.mp4
        self.mp4_preview = model.mp4_preview
        self.mp4_download = model.mp4_download
    }
}
