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


extension View{
    func dividerModifer(height: CGFloat = 25, color: Color = .gray) -> some View {
        self.modifier(DividerModifier(height: height, color: color))
    }
}



