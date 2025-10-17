//
//  View+Extensions.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//

import Foundation
import SwiftUI

struct DividerViewModifer: ViewModifier {
    var height: CGFloat = 25
    var color: Color = .gray
    
    func body(content:Content) -> some View {
        Divider()
            .frame(height: height)
            .background(color)
    }
}


extension View{
    func dividerViewModifier(height: CGFloat = 25, color: Color = .gray) -> some View{
          self.modifier(DividerViewModifer(height: height, color: color))
      }
}
