//
//  TabBarView.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/12/25.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab: AppTab
    
    var body: some View {
        
        HStack {
            ForEach(AppTab.allCases) { tab in
                Button(action: {
                    withAnimation {
                        selectedTab = tab
                    }
                }) {
                    VStack(spacing:10){
                        Image(systemName: tab.icons)
                            .font(.system(size: 22))
                            .foregroundColor(selectedTab == tab ? .white.opacity(0.8) : .white)
                        Text(tab.title)
                            .font(.subheadline)
                            .foregroundColor(selectedTab == tab ? .white.opacity(0.8) : .white)
                    }
                    .padding(.vertical, 7)
                    .frame(maxWidth: .infinity)
                    .background(
                        Color.white.opacity(selectedTab == tab ? 0.1 : 0)
                    )
                }
                
            }
        }
        .background(Color.black.opacity(0.7))
    }
}

#Preview {
    @Previewable @State var selectedTab: AppTab = .home
    TabBarView(selectedTab: $selectedTab)
}
