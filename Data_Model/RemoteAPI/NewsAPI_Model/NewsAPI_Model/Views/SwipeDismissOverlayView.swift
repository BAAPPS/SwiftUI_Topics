//
//  SwipeDismissOverlayView.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import SwiftUI


struct SwipeDismissOverlayView<Content: View, T: Identifiable>: View {
    @Binding var selectedItem: T?
    var animation: Namespace.ID
    let content: (T) -> Content
    
    @State private var dragOffset: CGFloat = 0
    
    var body: some View {
        if let item = selectedItem {
            ZStack {
                // Dimmed background
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                            selectedItem = nil
                            dragOffset = 0
                        }
                    }
                
                // Content with swipe-to-dismiss
                content(item)
                    .matchedGeometryEffect(id: item.id, in: animation)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
                    .cornerRadius(0)
                    .ignoresSafeArea()
                    .offset(y: dragOffset)
                    .highPriorityGesture(
                        DragGesture()
                            .onChanged { value in
                                if value.translation.height > 0 {
                                    dragOffset = value.translation.height
                                }
                            }
                            .onEnded { value in
                                if value.translation.height > 150 {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                        selectedItem = nil
                                        dragOffset = 0
                                    }
                                } else {
                                    withAnimation(.spring()) {
                                        dragOffset = 0
                                    }
                                }
                            }
                    )
            }
            .transition(.opacity)
            .zIndex(1)
        }
    }
}

#Preview {
    @Previewable @Namespace var animation
    @Previewable @State var selectedArticle: ArticleModel? = .mock
    
    SwipeDismissOverlayView(selectedItem: $selectedArticle, animation: animation) { article in
        NewsDetailView(article: article) {
            selectedArticle = nil
        }
    }
}
