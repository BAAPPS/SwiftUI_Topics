//
//  NewsFeedView.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import SwiftUI
import Kingfisher

struct NewsFeedView: View {
    let articles: [ArticleModel]
    @Environment(NewsViewModel.self) var newsViewModel
    @Binding var selectedArticle: ArticleModel?
    var animation: Namespace.ID
    var fetchNextPage: (() -> Void)? = nil

     
    var body: some View {
        ZStack {
            // Loading / Error / List
            if articles.isEmpty {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = newsViewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(articles) { article in
                            NewsCardView(article: article, animation: animation) { tappedArticle in
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                    selectedArticle = tappedArticle
                                }
                            }
                        }
                        
                        if fetchNextPage != nil {
                            ProgressView()
                                .padding()
                                .frame(maxWidth:.infinity, alignment: .center)
                        }
                    }
                    .animation(.default, value: articles)
                }
            }
        }
    }
}

#Preview {
    @Previewable @Namespace var animation
    @Previewable @State var selected: ArticleModel? = nil

    NewsFeedView(articles: [.mock], selectedArticle: $selected, animation: animation)
        .environment(NewsViewModel())
}
