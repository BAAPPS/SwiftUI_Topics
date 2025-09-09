//
//  TabContentView.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import SwiftUI

struct TabContentView: View {
    @Environment(NewsViewModel.self) var newsViewModel
    @Binding var selectedTab: AppTab

    var body: some View {
        Group {
            switch selectedTab {
            case .all:
                AllNewsView()
                    .environment(newsViewModel)
            case .topHeadlines:
                TopHeadlineNewsView()
                    .environment(newsViewModel)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    @Previewable @State var selectedTab: AppTab = .all
    
    TabContentView(selectedTab: $selectedTab)
        .environment(NewsViewModel())
}
