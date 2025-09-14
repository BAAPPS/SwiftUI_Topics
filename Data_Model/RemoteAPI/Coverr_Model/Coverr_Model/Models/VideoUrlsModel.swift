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
