//
//  ScrollViewPill.swift
//  SwiftWatchlist
//
//  Created by D F on 9/26/25.
//

import Foundation
import SwiftUI

struct HorizontalPillScroll<Data: Identifiable, Content: View>: View {
    let items: [Data]
    let content: (Data) -> Content
    let spacing: CGFloat
    let verticalPadding: CGFloat
    let horizontalPadding: CGFloat
    
    
    init(
        items: [Data],
        spacing: CGFloat = 8,
        verticalPadding: CGFloat = 10,
        horizontalPadding: CGFloat = 5,
        @ViewBuilder content: @escaping (Data) -> Content
    ) {
        self.items = items
        self.spacing = spacing
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.content = content
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacing){
                ForEach(items) {item in
                    content(item)
                }
            }
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            // Ensure HStack is at least screen width so content centers when few items are present
            .frame(minWidth: UIScreen.main.bounds.width, alignment: .center)
        }
    }
}
