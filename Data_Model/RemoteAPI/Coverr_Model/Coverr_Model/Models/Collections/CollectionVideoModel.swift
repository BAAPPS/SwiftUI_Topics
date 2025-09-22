//
//  CollectionVideo.swift
//  Coverr_Model
//
//  Created by D F on 9/21/25.
//

import Foundation

struct CollectionVideoModel: Identifiable {
    let id: String
    let collectionID: String
    let video: VideoHitsModel
    
    init(collectionID: String, video: VideoHitsModel) {
        self.collectionID = collectionID
        self.video = video
        self.id = video.id
    }
}
