//
//  StarRatingView.swift
//  SwiftWatchlist
//
//  Created by D F on 9/26/25.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double // 0-10
    let maxRating: Int = 5
    let starSize: CGFloat
    let showNumeric: Bool
    
    // Normalize rating to a scale of 0–5 stars
    private var normalizedRating: Double {
        min(max(rating / 2, 0), Double(maxRating))
    }
    
    var body: some View {
        HStack(spacing: 4) {
            HStack(spacing: 2) {
                ForEach(1...maxRating, id: \.self) { index in
                    Image(systemName: starType(for: index))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: starSize, height: starSize)
                        .foregroundColor(.blue.opacity(0.9))
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(
                "Rating: \(String(format: "%.1f", rating)) out of 10, " +
                "displayed as \(String(format: "%.1f", normalizedRating)) out of \(maxRating) stars"
            )
            
            if showNumeric {
                Text(String(format: "%.1f / 10", rating))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private func starType(for position: Int) -> String {
        let difference = normalizedRating - Double(position - 1)
        
        if difference >= 1 {
            return "star.fill" // full star
        } else if difference >= 0.5 {
            return "star.leadinghalf.filled" // half star
        } else {
            return "star" // empty star
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        StarRatingView(rating: 8.1, starSize: 16, showNumeric: true)
        StarRatingView(rating: 4.5, starSize: 16, showNumeric: true)
        StarRatingView(rating: 9.2, starSize: 16, showNumeric: false)
    }
}
