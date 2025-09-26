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
    let accessibilityLabel: String? // Optional label for context
    
    init(
        items: [Data],
        spacing: CGFloat = 8,
        verticalPadding: CGFloat = 10,
        horizontalPadding: CGFloat = 5,
        accessibilityLabel: String? = nil, // New
        @ViewBuilder content: @escaping (Data) -> Content
    ) {
        self.items = items
        self.spacing = spacing
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.accessibilityLabel = accessibilityLabel
        self.content = content
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacing) {
                ForEach(items) { item in
                    content(item)
                        .accessibilityElement(children: .combine) // Group content for clarity
                }
            }
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .frame(minWidth: UIScreen.main.bounds.width, alignment: .center)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabel ?? "Horizontal pill list")
        .accessibilityHint("Swipe left or right to explore")
    }
}
