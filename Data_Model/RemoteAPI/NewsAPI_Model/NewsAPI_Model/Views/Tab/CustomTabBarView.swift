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
    
    var body: some View {
        VStack(spacing:0) {
            // MARK: - Tab Content
            TabContentView(selectedTab: $selectedTab)
                .environment(newsViewModel)
            
            // MARK: - Custom Tab Bar
            TabBarView(selectedTab: $selectedTab)  
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    CustomTabBarView()
        .environment(NewsViewModel())
}
