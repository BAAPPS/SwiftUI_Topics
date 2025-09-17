//
//  VideoDetailsView.swift
//  Coverr_Model
//
//  Created by D F on 9/16/25.
//

import SwiftUI

struct VideoDetailsView: View {
    let video: VideoHitsModel
    
    let columns = [GridItem(.adaptive(minimum: 95), spacing: 8),]
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(video.description)
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack(spacing: 10) {
                if let createdAt = video.createdAt {
                    IconTextRow(systemName: "calendar", text: createdAt.displayString)
                }
                
                if let publishedAt = video.publishedAt {
                    dividerModifier()
                    IconTextRow(systemName: "arrow.up.circle", text: publishedAt.displayString)
                }
                
                if let updatedAt = video.updatedAt {
                    dividerModifier()
                    IconTextRow(systemName: "arrow.triangle.2.circlepath", text: updatedAt.displayString)
                }
                
                
            }
            .padding(.top, 10)
            
            if let tags = video.tags {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.top, 10)
                            .frame(maxWidth:.infinity, alignment: .topLeading)
                    }
                }
                .padding()
            }
            
        }
    }
}

#Preview {
    VideoDetailsView(video: .example )
}
