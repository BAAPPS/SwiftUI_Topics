//
//  View+Extensions.swift
//  Coverr_Model
//
//  Created by D F on 9/16/25.
//

import Foundation
import SwiftUI


// MARK: - Date formatting for views
extension Date {
    var displayString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium   // Sep 16, 2025
        formatter.timeStyle = .none     // no time shown
        // formatter.timeStyle = .short    // 7:30 PM
        return formatter.string(from: self)
    }
}


// MARK: - ViewModifier

struct DividerModifer: ViewModifier {
    var height: CGFloat = 25
    var color: Color = .black
    func body(content: Content) -> some View {
        Divider()
            .frame(height: height)
            .foregroundColor(color)
    }
}


extension View {
    
    func dividerModifier(height: CGFloat = 25, color: Color = .black) -> some View {
        self.modifier(DividerModifer(height: height, color: color))
    }
}

// MARK: - View
struct IconTextRow: View {
    let systemName: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .foregroundColor(.black.opacity(0.5))
                .font(.title2)
                .frame(width: 20, alignment: .center)
            Text(text)
                . font(.callout)
                .foregroundColor(.black.opacity(0.7))
                .fixedSize(horizontal: false, vertical: true)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(text)")
        .accessibilityAddTraits(.isStaticText)
    }
}
