//
//  StarRatingView.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/10/25.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double // 0-5
    let maxRating: Int = 5
    let starSize: CGFloat
    var body: some View {
        HStack(spacing:4) {
            HStack(spacing:2) {
                ForEach(1...maxRating, id:\.self) {
                    index in
                    
                    Image(systemName: starType(for: index))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: starSize, height: starSize)
                        .foregroundColor(.orange)
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("\(String(format: "%.1f", rating)) out of \(maxRating) stars")
        }
    }
    
    private func starType(for position: Int) -> String {
        if Double(position) <= rating {
            return "star.fill" // full star
        } else if Double(position) - rating <= 0.5 {
            return "star.leadinghalf.filled" // half star
        } else {
            return "star" // empty star
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        StarRatingView(rating: 3.5, starSize: 16)
        StarRatingView(rating: 4.5, starSize: 16)
        StarRatingView(rating:1.5, starSize: 16)
    }
}
