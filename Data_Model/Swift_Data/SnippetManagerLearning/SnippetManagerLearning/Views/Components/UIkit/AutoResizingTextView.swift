//
//  AutoResizingTextView.swift
//  SnippetManagerLearning
//
//  Created by D F on 10/14/25.
//

import SwiftUI
import UIKit

struct AutoResizingTextView: UIViewRepresentable {
    @Binding var text: String
    @Binding var height: CGFloat
    
    
    var blockType: TypingBlockType

    
    var onHeader: (Int) -> Void
    var onParagraph: () -> Void
    var onCode: () -> Void
    var onComponent: () -> Void
    
    var minHeight: CGFloat = 100
    var maxHeight: CGFloat = 400
    var font: UIFont = .monospacedSystemFont(ofSize: 17, weight: .regular)
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.isSelectable = true
        textView.isScrollEnabled = true
        textView.font = font
        textView.backgroundColor = UIColor.secondarySystemBackground
        textView.layer.cornerRadius = 8
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.delegate = context.coordinator
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        // Keyboard toolbar with Done button
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.autoresizingMask = [.flexibleWidth]
        
        let h1Button = UIBarButtonItem(image: UIImage(systemName: "1.circle"), style: .plain, target: context.coordinator, action: #selector(Coordinator.header1Tapped))
        let h2Button = UIBarButtonItem(image: UIImage(systemName: "2.circle"), style: .plain, target: context.coordinator, action: #selector(Coordinator.header2Tapped))
        let paragraphButton = UIBarButtonItem( image: UIImage(systemName: "paragraph"), style: .plain, target: context.coordinator, action: #selector(Coordinator.paragraphTapped))
        let codeButton = UIBarButtonItem(   image: UIImage(systemName: "curlybraces"), style: .plain, target: context.coordinator, action: #selector(Coordinator.codeTapped))
        let componentButton = UIBarButtonItem(   image: UIImage(systemName: "square.stack.3d.up"), style: .plain, target: context.coordinator, action: #selector(Coordinator.componentTapped))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: context.coordinator, action: #selector(Coordinator.doneTapped))
        
        toolbar.items = [
            h1Button, flexSpace,
            h2Button, flexSpace,
            paragraphButton, flexSpace,
            codeButton, flexSpace,
            componentButton, flexSpace,
            doneButton
        ]
        textView.inputAccessoryView = toolbar
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        
        DispatchQueue.main.async {
            let width = max(uiView.bounds.width, 1)
            let size = uiView.sizeThatFits(CGSize(width: width, height: .infinity))
            let newHeight = min(max(size.height, minHeight), maxHeight)
            
            if height != newHeight {
                if height == minHeight {
                    height = newHeight
                } else {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        height = newHeight
                    }
                }
            }
            
            // Enable scrolling only after reaching maxHeight
            uiView.isScrollEnabled = size.height > maxHeight
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: AutoResizingTextView
        
        init(_ parent: AutoResizingTextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            // Enter just inserts a newline
            return true
        }


        @objc func doneTapped() {
            DispatchQueue.main.async {
                UIView.performWithoutAnimation {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
        }
        
        @objc func header1Tapped() {
            parent.onHeader(1)
        }
        
        @objc func header2Tapped() {
            parent.onHeader(2)
        }
        
        @objc func paragraphTapped() {
            parent.onParagraph()
        }
        
        @objc func codeTapped() {
            parent.onCode()
        }
        
        @objc func componentTapped() {
            parent.onComponent()
        }
    }
}
