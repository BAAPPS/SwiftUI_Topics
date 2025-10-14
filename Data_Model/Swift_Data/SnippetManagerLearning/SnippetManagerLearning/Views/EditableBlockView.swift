//
//  EditBlockView.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/14/25.
//

import SwiftUI
import SwiftData

struct EditableBlockView: View {
    @Binding var block: EditableBlock
    @Bindable var snippetVM: SnippetViewModel
    @Binding var textViewHeight: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text(block.type.displayName)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding()
            
            AutoResizingTextView(
                text: $block.text,
                height: $textViewHeight,
                blockType: block.type,
                onHeader: { snippetVM.switchType(for: block, to: .header(level: $0)) },
                onParagraph: { snippetVM.switchType(for: block, to: .paragraph) },
                onCode: { snippetVM.switchType(for: block,to: .code(language: .swift)) },
                onComponent: { snippetVM.switchType(for: block,to: .component) }
            )
            .frame(height: textViewHeight)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .padding(.horizontal)
        }
    }
}


#Preview {
    EditableBlockView(
        block: .constant(EditableBlock(type: .paragraph, text: "Sample text")),
        snippetVM: SnippetViewModel(context: try! ModelContext(ModelContainer(for: Snippet.self))),
        textViewHeight: .constant(100)
    )
}
