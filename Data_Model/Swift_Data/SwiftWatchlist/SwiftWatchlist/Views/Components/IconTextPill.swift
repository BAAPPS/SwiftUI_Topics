//
//  IconTextPill.swift
//  SwiftWatchlist
//
//  Created by D F on 9/26/25.
//

import Foundation
import SwiftUI

struct IconTextPill: View {
    let icon: String       // SF Symbol or emoji
    let text: String
    let color: Color?
    let font: Font
    init(icon: String, text: String, color: Color? = nil, font: Font = .caption2) {
        self.icon = icon
        self.text = text
        self.color = color
        self.font = font
    }
    
    var body: some View {
        HStack(spacing: 4) {
            // Icon: SF Symbol or emoji
            if UIImage(systemName: icon) != nil {
                Image(systemName: icon)
                    .font(font)  // <-- apply custom font
                    .alignmentGuide(.firstTextBaseline) { d in d[VerticalAlignment.center] }
            } else {
                Text(icon)
                    .font(font)
                    .alignmentGuide(.firstTextBaseline) { d in d[VerticalAlignment.center] }
            }
            
            Text(text)
                .font(font)  // <-- apply custom font
                .foregroundColor(.primary)
                .alignmentGuide(.firstTextBaseline) { d in d[VerticalAlignment.center] }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background((color ?? .gray).opacity(0.15))
        .cornerRadius(12)
        .accessibilityElement(children: .ignore) // Ignore sub-elements, treat as one pill
        .accessibilityLabel(accessibilityLabel)
        .accessibilityAddTraits(.isStaticText) 
    }
    private var accessibilityLabel: String {
        if UIImage(systemName: icon) != nil {
            return "\(text), icon: \(icon)"
        } else {
            return "\(text), symbol: \(icon)"
        }
    }
}
