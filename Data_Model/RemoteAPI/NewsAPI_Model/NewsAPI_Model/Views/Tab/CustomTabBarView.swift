//
//  CustomTabBarView.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import SwiftUI

struct CustomTabBarView: View {
    @Environment(NewsViewModel.self) var newsViewModel
    @State private var selectedTab: AppTab = .all
    @State private var selectedArticle: ArticleModel? = nil
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            // MARK: - Tab Content
            TabContentView(selectedTab: $selectedTab,
                           selectedArticle: $selectedArticle,
                           animation: animation)
            .environment(newsViewModel)
            
            // MARK: - Overlay (Full screen detail)
            SwipeDismissOverlayView(selectedItem: $selectedArticle,
                                    animation: animation) { article, close in
                NewsDetailView(article: article) {
                    close()
                }
            }
            
            // MARK: - Tab Bar (hide if detail is showing)
            VStack {
                Spacer()
                TabBarView(selectedTab: $selectedTab)
                    .offset(y: selectedArticle != nil ? 100 : 0) // slide down when overlay open
                    .animation(.easeInOut(duration: 0.3), value: selectedArticle)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


#Preview {
    CustomTabBarView()
        .environment(NewsViewModel())
}
