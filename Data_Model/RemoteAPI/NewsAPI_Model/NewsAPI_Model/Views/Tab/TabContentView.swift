//
//  TabContentView.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import SwiftUI

import SwiftUI

struct TabContentView: View {
    @Environment(NewsViewModel.self) var newsViewModel
    @Binding var selectedTab: AppTab
    @Binding var selectedArticle: ArticleModel?
    var animation: Namespace.ID
    
    var body: some View {
        switch selectedTab {
        case .all:
            AllNewsView(selectedArticle: $selectedArticle, animation: animation)
                .environment(newsViewModel)
        case .topHeadlines:
            TopHeadlineNewsView(selectedArticle: $selectedArticle, animation: animation)
                .environment(newsViewModel)
        }
        
    }
}


#Preview {
    @Previewable @State var selectedTab: AppTab = .all
    @Previewable @State var selectedArticle: ArticleModel? = .mock
    @Previewable @Namespace var animation
    
    TabContentView(
        selectedTab: $selectedTab,
        selectedArticle: $selectedArticle,
        animation: animation
    )
    .environment(NewsViewModel())
}
