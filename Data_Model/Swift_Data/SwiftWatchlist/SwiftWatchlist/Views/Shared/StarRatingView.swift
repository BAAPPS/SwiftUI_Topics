//
//  StarRatingView.swift
//  SwiftWatchlist
//
//  Created by D F on 9/26/25.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double // 0.5 to 5.0
    let maxRating: Int = 5
    let starSize: CGFloat
    
    var body: some View {
        HStack(spacing:2) {
            ForEach(1...maxRating, id: \.self) { index in
                Image(systemName: starType(for: index))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: starSize, height: starSize)
                    .foregroundColor(.blue.opacity(0.9))
            }
        }
    }
    
    private func starType(for position: Int) -> String {
        switch rating {
        case let r where r >= Double(position) :
            return "star.fill"   // full star
        case let r where r >= Double(position) - 0.5:
            return "star.leadinghalf.filled" // half star
        default:
            return "star" // empty star
        }
    }
}

#Preview {
    StarRatingView(rating: 3.5, starSize: 16)
}
