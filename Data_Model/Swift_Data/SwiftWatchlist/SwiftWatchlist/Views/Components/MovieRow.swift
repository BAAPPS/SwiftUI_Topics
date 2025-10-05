//
//  MovieRow.swift
//  SwiftWatchlist
//
//  Created by D F on 10/5/25.
//

import SwiftUI
import Kingfisher

struct MovieRow: View {
    let movie: Movie

    var body: some View {
        NavigationLink(value: movie) {
            HStack(alignment:.center) {
                Text(movie.title)
                    .font(.system(size: 15, weight: .medium))
                    .lineLimit(2)
                Spacer()
                KFImage(URL(string: movie.posterPath))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .clipped()
                    .accessibilityHidden(true)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.vertical, 4)
        }
    }
}
