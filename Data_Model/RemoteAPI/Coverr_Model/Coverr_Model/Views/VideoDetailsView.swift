//
//  VideoDetailsView.swift
//  Coverr_Model
//
//  Created by D F on 9/16/25.
//

import SwiftUI

struct VideoDetailsView: View {
    let video: VideoHitsModel
    var body: some View {
        ZStack {
            Text(video.description)
        }
    }
}

#Preview {
    VideoDetailsView(video: .example )
}
