//
//  TabBarView.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab: AppTab
    
    var body: some View {
        HStack {
            ForEach(AppTab.allCases) { tab  in
                // Frst and last tabs get the rounded ends, middle none
                let isFirst = tab == AppTab.allCases.first
                let isLast  = tab == AppTab.allCases.last
                Button(action: {
                    withAnimation {
                        selectedTab = tab
                    }
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tab.systemIcon)
                            .font(.system(size: 22))
                            .foregroundColor(selectedTab == tab ? .blue : .gray)
                        Text(tab.title)
                            .font(.caption)
                            .foregroundColor(selectedTab == tab ? .blue : .gray)
                    }
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(
                        Color.blue.opacity(selectedTab == tab ? 0.1 : 0)
                            .cornerRadiusModifier(16,
                                    corners: isFirst ? [.topRight, .bottomRight] :
                                    isLast  ? [.topLeft, .bottomLeft] :[])
                        
                    )
                }
                
            }
        }
        .background(.ultraThinMaterial)
    }
}

#Preview {
    TabBarView(selectedTab: .constant(.all))
}
