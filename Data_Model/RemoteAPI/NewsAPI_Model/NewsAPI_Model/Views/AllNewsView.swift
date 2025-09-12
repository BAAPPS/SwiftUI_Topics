//
//  EverythingNewsView.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import SwiftUI
import Kingfisher

import SwiftUI

struct AllNewsView: View {
    @Environment(NewsViewModel.self) var newsViewModel
    @State private var searchText: String = ""
    
    @Binding var selectedArticle: ArticleModel?
    var animation: Namespace.ID                 
    
    var body: some View {
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
        .onAppear {
            if newsViewModel.allArticles.isEmpty {
                newsViewModel.fetchAll(reset: true)
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedArticle: ArticleModel? = .mock
    @Previewable @Namespace var animation
    
    AllNewsView(selectedArticle: $selectedArticle, animation: animation)
        .environment(NewsViewModel())
}
