//
//  View+Extensions.swift
//  NewsAPI_Model
//
//  Created by D F on 9/12/25.
//

import SwiftUI



// MARK: - Shapes
struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}



extension View {
    func cornerRadiusModifier(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius:radius, corners: corners))
    }
}
