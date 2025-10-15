//
//  CommandPaletteView.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/14/25.
//

import SwiftUI

import SwiftUI

struct CommandPaletteView: View {
    var onSelect: (TypingBlockType) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Button("Header 1") { onSelect(.header(level: 1)) }
            Button("Header 2") { onSelect(.header(level: 2)) }
            Button("Paragraph") { onSelect(.paragraph) }
            Button("Code") { onSelect(.code(language: .swift)) }
            Button("Component") { onSelect(.component) }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(8)
        .shadow(radius: 5)
    }
}


#Preview {
    CommandPaletteView(onSelect: {_ in })
}
