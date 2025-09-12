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
        ZStack {
            // Background card shell
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.lochmara500)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                .matchedGeometryEffect(id: "\(article.id)-background", in: animation)
            
            VStack(alignment:.leading, spacing: 8) {
                if let imageUrlString = article.urlToImage,
                   let url = URL(string: imageUrlString) {
                    KFImage(url)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .cornerRadiusModifier(12, corners: [.topLeft, .topRight])
                        .clipped()
                        .accessibilityHidden(true)
                        .matchedGeometryEffect(id: "\(article.id)-image", in: animation)
                }
                
                VStack {
                    Text(article.title)
                        .font(.headline)
                        .bold()
                        .foregroundColor(.lochmara50)
                        .matchedGeometryEffect(id: "\(article.id)-title", in: animation)
                    
                    HStack {
                        if let author = article.author {
                            Image(systemName: "pencil")
                                .foregroundColor(.lochmara100)
                                .accessibilityHidden(true)
                            Text(author)
                                .foregroundColor(.lochmara100)
                        }
                    }
                    .padding(.top, 10)
                    .font(.subheadline)
                    .frame(maxWidth:.infinity, alignment: .bottomTrailing)
                    
                }
                .padding()
                .background(Color.lochmara500.opacity(0.001))
            }
            .onTapGesture { onTap(article) }
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isButton)
            .accessibilityLabel(makeAccessibilityLabel(for: article))
            .accessibilityHint("Tap to read full article")
        }
        .padding()
        
    }
    
    // MARK: - Helper
    private func makeAccessibilityLabel(for article: ArticleModel) -> String {
        var label = article.title
        if let author = article.author {
            label += ". By \(author)."
        }
        return label
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
    .frame(width:.infinity, height: 300)
}
