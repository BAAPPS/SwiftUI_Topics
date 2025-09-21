//
//  TabBarView.swift
//  Coverr_Model
//
//  Created by D F on 9/21/25.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var selectedTab: AppTab
    
    var body: some View {
        HStack{
            ForEach(AppTab.allCases) {tab in
                let isFirst = tab == AppTab.allCases.first
                let isLast = tab == AppTab.allCases.last
                
                Button(action: {
                    withAnimation {
                        selectedTab = tab
                    }
                }) {
                    VStack(spacing: 7) {
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
                        Color.black.opacity(selectedTab == tab ? 0.1 : 0)
                            .cornerRadiusModifier(15, corners: isFirst ? [.topRight, .bottomRight]: isLast ? [.topLeft, .bottomLeft] : [])
                    )
                }
            }
        }
        .background(.ultraThinMaterial)
    }
}

#Preview {
    ZStack{
        Color.black.opacity(0.7)
            .ignoresSafeArea()
        VStack{
            Spacer()
            TabBarView(selectedTab: .constant(.all))
        }
    }
}
