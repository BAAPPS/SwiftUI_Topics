//
//  SwipeDismissOverlayView.swift
//  NewsAPI_Model
//
//  Created by D F on 9/12/25.
//

import SwiftUI

struct SwipeDismissOverlayView<Content: View, T: Identifiable & Equatable>: View {
    @Binding var selectedItem: T?
    var animation: Namespace.ID
    let content: (T, @escaping () -> Void) -> Content
    
    @State private var overlayItem: T? = nil
    @State private var dragOffset: CGFloat = 0
    @State private var isClosing: Bool = false
    
    private let animationDuration: Double = 0.35
    
    @State private var overlayOpacity: Double = 1

    
    var body: some View {
        ZStack {
            // Dimmed background
            if overlayItem != nil {
                Color.black.opacity(isClosing ? 0 : 0.3)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture { close() }
                    .animation(.easeInOut(duration: animationDuration), value: isClosing)
            }
            
            // Overlay content
            if let item = overlayItem {
                content(item, close)
                    .matchedGeometryEffect(id: item.id, in: animation)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .scaleEffect(isClosing ? 0.95 : 1)
                    .opacity(overlayOpacity)
                    .offset(y: dragOffset)
                    .highPriorityGesture(dragGesture)
                    .animation(.interactiveSpring(response: 0.45, dampingFraction: 0.85, blendDuration: 0.25), value: dragOffset)
                    .transition(.opacity.combined(with: .scale))
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onChange(of: selectedItem) { _, newValue in
            if let newItem = newValue {
                // Animate to full screen
                withAnimation(.interactiveSpring(response: 0.45, dampingFraction: 0.85)) {
                    // Show overlay
                    overlayItem = newItem
                    dragOffset = 0
                    isClosing = false
                    overlayOpacity = 1
                }
            } else {
                close()
            }
        }
        
        .onAppear {
            if let item = selectedItem {
                overlayItem = item
            }
        }
    }
    
    // MARK: - Drag gesture
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.height > 0 {
                    dragOffset = value.translation.height
                }
            }
            .onEnded { value in
                if value.translation.height > 150 {
                    close()
                } else {
                    withAnimation(.interactiveSpring(response: 0.45, dampingFraction: 0.85, blendDuration: 0.25)) {
                        dragOffset = 0
                    }
                }
            }
    }
    
    // MARK: - Close overlay
    private func close() {
        guard overlayItem != nil else { return }
        
        withAnimation(.interactiveSpring(response: 0.45, dampingFraction: 0.85, blendDuration: 0.40)) {
            dragOffset = 1000
            isClosing = true
            overlayOpacity = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            overlayItem = nil
            dragOffset = 0
            isClosing = false
            overlayOpacity = 1
            selectedItem = nil
        }
    }
    
}

#Preview {
    @Previewable @Namespace var animation
    @Previewable @State var selectedArticle: ArticleModel? = .mock
    
    SwipeDismissOverlayView(selectedItem: $selectedArticle, animation: animation) { article, close in
        NewsDetailView(article: article) {
            close()
        }
        
    }
}
