//
//  TopHeadlineNewsView.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import SwiftUI

struct TopHeadlineNewsView: View {
    @Environment(NewsViewModel.self) var newsViewModel

    @Binding var selectedArticle: ArticleModel?
    var animation: Namespace.ID
    
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
            
            SwipeDismissOverlayView(selectedItem: $selectedArticle, animation: animation) { article, close in
                NewsDetailView(article: article) {
                    close()
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
    @Previewable @State var selectedArticle: ArticleModel? = .mock
    @Previewable @Namespace var animation
    TopHeadlineNewsView(selectedArticle: $selectedArticle, animation: animation)
        .environment(NewsViewModel())
}

