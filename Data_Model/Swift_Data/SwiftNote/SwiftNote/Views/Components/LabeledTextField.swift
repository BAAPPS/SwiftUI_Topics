//
//  LabeledTextField.swift
//  SwiftNote
//
//  Created by D F on 9/23/25.
//

import Foundation
import SwiftUI

struct LabeledTextField: View{
    let label: String
    let placeholder: String
    @Binding var text: String
    
    // Optional styling parameters
    var labelFont: Font = .title3
    var labelWeight: Font.Weight = .bold
    var backgroundColor: Color = Color.black.opacity(0.8)
    var textColor: Color = .white
    var cornerRadius: CGFloat = 8
    var padding: CGFloat = 13
    var foregroundColor: Color = .gray
    var paddingHorizontal: CGFloat = 8
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(labelFont)
                .bold()
            
            ZStack(alignment:.topLeading){
                // Placeholder
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(foregroundColor)
                        .padding(.horizontal, paddingHorizontal)
                        .allowsHitTesting(false)
                        .accessibilityHidden(true)
                }
                // TextField
                TextField(
                    text: $text,
                    prompt: nil
                ) { }
                    .foregroundColor(textColor)
                    .autocapitalization(.sentences)
                    .accessibilityLabel("\(label), \(placeholder)")
            }
            .padding(padding)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            
        }
    }
}

