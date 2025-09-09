//
//  TopHeadlineNewsView.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import SwiftUI

struct TopHeadlineNewsView: View {
    @Environment(NewsViewModel.self) var newsViewModel
    @Namespace private var animation
    
    @State private var selectedArticle: ArticleModel? = nil
    
    var body: some View {
        @Bindable var newsViewModel = newsViewModel
        ZStack {
            VStack(spacing: 0) {
                // MARK: - Category Picker
                Picker("Category", selection: $newsViewModel.topHeadlineCategory) {
                    Text("All").tag(nil as TopHeadlineCategory?)
                    ForEach(TopHeadlineCategory.allCases, id: \.self) { category in
                        Text(category.rawValue.capitalized).tag(Optional(category))
                    }
                }
                .pickerStyle(.wheel)
                .labelsHidden()
                .frame(height: 110)
                .accessibilityLabel("News category")
                .accessibilityHint("Swipe up or down to change the category of headlines")
                
                
                // MARK: - Feed
                
                NewsFeedView(
                    articles: newsViewModel.topHeadlines,
                    selectedArticle: $selectedArticle,
                    animation: animation,
                    fetchNextPage: { newsViewModel.fetchTopNextPage() }   
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
            if newsViewModel.topHeadlines.isEmpty {
                newsViewModel.fetchTopHeadlines(reset: true)
            }
        }
    }
}

#Preview {
    TopHeadlineNewsView()
        .environment(NewsViewModel())
}

