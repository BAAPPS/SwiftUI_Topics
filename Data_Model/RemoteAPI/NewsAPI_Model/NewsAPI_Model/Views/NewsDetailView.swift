//
//  NewsFeedDetailView.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import SwiftUI
import Kingfisher

struct NewsDetailView: View {
    let article: ArticleModel
    var onDone: () -> Void  // ✅ custom closure
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageUrlString = article.urlToImage,
                   let url = URL(string: imageUrlString) {
                    KFImage(url)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 250)
                        .clipped()
                        .accessibilityHidden(true)
                    
                }
                
                VStack{
                    Text(article.title)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.lochmara950)
                    
                    if let author = article.author {
                        Text("By \(author)")
                            .font(.subheadline)
                            .foregroundColor(.lochmara700)
                    }
                    
                    if let description = article.description {
                        Text(description)
                            .font(.body)
                            .padding(.top, 10)
                            .foregroundColor(.lochmara950)
                    }
                }
                .padding()
                .accessibilityElement(children: .combine)
                .accessibilityLabel(makeAccessibilityLabel(for: article))
                .accessibilityHint("Read the article.")
                
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityHint("Swipe down to close this detail view.")
        .overlay(
            HStack {
                Spacer()
                Button {
                    onDone()
                } label: {
                    Image(systemName: "xmark")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.lochmara950)
                        .clipShape(Circle())
                        .accessibilityHidden(true)
                }
                .padding()
                .offset(y:40)
                .accessibilityLabel("Tap to close detail")
                .accessibilityAddTraits(.isButton)
                
                
            },
            alignment: .topTrailing
        )
        
    }
    // MARK: - Helper for accessibility label
    private func makeAccessibilityLabel(for article: ArticleModel) -> String {
        var label = article.title
        if let author = article.author {
            label += ". By \(author)."
        }
        if let description = article.description {
            label += " \(description)"
        }
        return label
    }
}


#Preview {
    NewsDetailView(article: .mock, onDone: {})
}
