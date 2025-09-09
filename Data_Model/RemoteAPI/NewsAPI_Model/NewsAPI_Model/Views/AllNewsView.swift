//
//  EverythingNewsView.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import SwiftUI
import Kingfisher

struct AllNewsView: View {
    @Environment(NewsViewModel.self) var newsViewModel
    @State private var searchText: String = ""
    @Namespace private var animation
    
    @State private var selectedArticle: ArticleModel? = nil
    
    @State private var dragOffset: CGFloat = 0
    
    
    var body: some View {
        ZStack {
            VStack {
                SearchBarView(text: $searchText, placeholder: "Search by topic...") {
                    newsViewModel.queryText = searchText
                }
                .padding(.top, 10)
                
                NewsFeedView(
                    articles: newsViewModel.allArticles,
                    selectedArticle: $selectedArticle,
                    animation: animation,
                    fetchNextPage: { newsViewModel.fetchAllNextPage() }
                )
                .environment(newsViewModel)
            }
            
            SwipeDismissOverlayView(selectedItem: $selectedArticle, animation: animation) { article in
                NewsDetailView(article: article) {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                        selectedArticle = nil
                    }
                }
            }
        }
        .onAppear {
            if newsViewModel.allArticles.isEmpty {
                newsViewModel.fetchAll(reset: true)
            }
        }
    }
}


#Preview {
    AllNewsView()
        .environment(NewsViewModel())
}
