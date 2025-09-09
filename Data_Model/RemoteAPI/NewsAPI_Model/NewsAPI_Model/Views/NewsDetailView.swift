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
                }
                
                VStack{
                    Text(article.title)
                        .font(.title2)
                        .bold()
                    
                    if let author = article.author {
                        Text("By \(author)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    if let description = article.description {
                        Text(description)
                            .font(.body)
                            .padding(.top, 10)
                    }
                }
                .padding()
            }
        }
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
                        .background(Color(.red).opacity(0.8))
                        .clipShape(Circle())
                }
                .padding()
            },
            alignment: .topTrailing
        )
        
    }
}


#Preview {
    NewsDetailView(article: .mock, onDone: {})
}
