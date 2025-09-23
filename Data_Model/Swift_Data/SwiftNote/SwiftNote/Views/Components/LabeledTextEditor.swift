//
//  LabeledTextEditor.swift
//  SwiftNote
//
//  Created by D F on 9/23/25.
//

import Foundation
import SwiftUI

struct LabeledTextEditor: View{
    let label: String
    let placeholder: String
    @Binding var text: String
    
    // Optional styling parameters
    var labelFont: Font = .title3
    var labelWeight: Font.Weight = .bold
    var backgroundColor: Color = Color.black.opacity(0.8)
    var textColor: Color = .white
    var cornerRadius: CGFloat = 8
    var padding: CGFloat = 10
    var foregroundColor: Color = .gray
    var minHeight: CGFloat = 40
    var maxHeight: CGFloat? = nil
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(labelFont)
                .bold()
            
            ZStack(alignment: .topLeading) {
                
                // Placeholder
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(foregroundColor)
                        .padding(padding)
                        .accessibilityHidden(true)
                }
                
                // TextEditor
                TextEditor(text: $text)
                    .foregroundColor(textColor)
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
                    .autocapitalization(.sentences)
                    .accessibilityLabel("\(label), \(placeholder)")
            }
            .padding(padding)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .frame(minHeight: minHeight, maxHeight: maxHeight)
        }
    }
}

