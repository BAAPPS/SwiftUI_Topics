//
//  View+Extensions.swift
//  SwiftWatchlist
//
//  Created by D F on 9/26/25.
//

import Foundation
import SwiftUI

// MARK: - View Modifier

struct DividerModifier: ViewModifier {
    var height: CGFloat = 25
    var color: Color = .gray
    
    func body(content: Content) -> some View {
        Divider()
            .frame(height: height)
            .background(color)
    }
}


struct OverlayEffectModifier: ViewModifier {
    var opacity: Double = 0.5
    var color: Color = .black
    
    func body(content: Content) -> some View {
        content
            .overlay(
                color
                    .opacity(opacity)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .ignoresSafeArea()
            )
    }
}


extension View{
    func dividerModifer(height: CGFloat = 25, color: Color = .gray) -> some View {
        self.modifier(DividerModifier(height: height, color: color))
    }
    
    func overlayEffect(opacity: Double = 0.5, color: Color = .black) -> some View {
        self.modifier(OverlayEffectModifier(opacity: opacity, color: color))
    }
}



