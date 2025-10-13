//
//  CustomMarkdownView.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/13/25.
//

import SwiftUI
struct CustomMarkdownView: View {
    let blocks: [MarkdownBlock]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(Array(blocks.enumerated()), id: \.offset) { index, block in
                blockView(for: block)
            }
        }
    }
    
    @ViewBuilder
    private func blockView(for block: MarkdownBlock) -> some View {
        switch block {
        case .header(let level, let text):
            Text(text)
                .font(headerFont(level: level))
                .bold()
        case .paragraph(let text):
            Text(text)
                .font(.body)
        case .code(_, let content):
            ScrollView(.horizontal) {
                Text(content)
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
            }
        case .component(key: let key):
           renderComponent(for: key)
        }
    }
    
    @ViewBuilder
    private func renderComponent(for key: String) -> some View {
        switch key {
        case "customWidget":
            Button("Tap Me") {
                print("Button tapped!")
            }
            .buttonStyle(.borderedProminent)
            .padding(.vertical, 4)

        case "diagramBlock":
            Image(systemName: "chart.bar.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .foregroundColor(.blue)
                .padding(.vertical, 4)

        case "toggleExample":
            Toggle("Enable Feature", isOn: .constant(true))
                .padding(.vertical, 4)

        default:
            Text("[Unknown component: \(key)]")
                .italic()
                .foregroundColor(.gray)
        }
    }
    
    private func headerFont(level: Int) -> Font {
        switch level {
        case 1: return .largeTitle
        case 2: return .title
        case 3: return .title2
        case 4: return .title3
        default: return .headline
        }
    }
}


#Preview {
    let sampleBlocks: [MarkdownBlock] = [
        .header(level: 1, text: "Welcome to SnippetManager"),
        .paragraph(text: "This is a paragraph describing your snippet."),
        .code(language: .javascript, context: "print(\"Hello World\")"),
        .component(key: "customWidget"),
        .component(key: "diagramBlock"),
        .component(key: "toggleExample"),
        .component(key: "unknownKey")
    ]
    
    CustomMarkdownView(blocks: sampleBlocks)
}
