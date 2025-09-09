//
//  NewsCardView.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import SwiftUI
import Kingfisher

struct NewsCardView: View {
    let article: ArticleModel
    var animation: Namespace.ID
    var onTap: (ArticleModel) -> Void
    
    var body: some View {
        VStack(alignment:.leading, spacing: 8) {
            if let imageUrlString = article.urlToImage,
               let url = URL(string: imageUrlString) {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(12)
                    .accessibilityHidden(true)
            }
            
            VStack {
                Text(article.title)
                    .font(.headline)
                
                HStack {
                    if let author = article.author {
                        Image(systemName: "pencil")
                            .accessibilityHidden(true)
                        Text(author)
                    }
                }
                .padding(.top, 10)
                .font(.subheadline)
                .frame(maxWidth:.infinity, alignment: .bottomTrailing)
            }
            .padding()
        }
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .matchedGeometryEffect(id: article.id, in: animation)
        .onTapGesture { onTap(article) }
    }
}


#Preview {
    @Previewable @Namespace var animation
    
    NewsCardView(
        article: .mock,
        animation: animation,
        onTap: { _ in
            print("Tapped card!")
        }
    )
}
