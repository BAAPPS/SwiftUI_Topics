//
//  View+Extensions.swift
//  LocalJSONModel
//
//  Created by D F on 9/2/25.
//

import SwiftUI

struct BannerSafeAreaModifier: ViewModifier {
    var allowUnderNavBar: Bool
    
    func body(content: Content) -> some View {
        if allowUnderNavBar {
            content.ignoresSafeArea(edges: .top)
        } else {
            content
        }
    }
}

struct DividerModifier: ViewModifier {
    var height: CGFloat = 25
    var color: Color = .black.opacity(0.6)
    
    func body(content: Content) -> some View {
        Divider()
            .frame(height: height)
            .background(color)
    }
}




extension View {
    func bannerSafeArea(allowUnderNavBar: Bool = false) -> some View {
        modifier(BannerSafeAreaModifier(allowUnderNavBar: allowUnderNavBar))
    }
    
    func shortDivider(height: CGFloat = 25, color: Color = .black.opacity(0.6)) -> some View {
        self.modifier(DividerModifier(height: height, color: color))
    }
}
