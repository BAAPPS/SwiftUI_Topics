//
//  SnapingPageView.swift
//  Coverr_Model
//
//  Created by D F on 9/15/25.
//

import SwiftUI

struct SnapPagingView<Content: View>: View {
    let pageCount: Int
    @Binding var currentPage: Int
    @Binding var dragOffset: CGFloat
    let content: (CGFloat, CGFloat) -> Content
    
    @GestureState private var gestureOffset: CGFloat = 0
    
    var body: some View {
        
        GeometryReader { geometry in
            let pageHeight = geometry.size.height
            let minOffset: CGFloat = -CGFloat(pageCount - 1) * pageHeight
            let maxOffset: CGFloat = 0
            let totalOffset = max(minOffset, min(maxOffset, -CGFloat(currentPage) * pageHeight + dragOffset))
            
            content(geometry.size.width, pageHeight)
                .frame(height: pageHeight * CGFloat(pageCount), alignment: .top)
                .offset(y: totalOffset)
                .animation(.easeInOut, value: currentPage)
                .gesture(
                    DragGesture()
                        .updating($gestureOffset) { value, state, _ in
                            state = value.translation.height
                        }
                        .onChanged { value in
                            dragOffset = value.translation.height
                        }
                        .onEnded { value in
                            let dragThreshold = pageHeight / 2
                            
                            if value.translation.height < -dragThreshold && currentPage < pageCount - 1 {
                                currentPage += 1
                            }
                            else if value.translation.height > dragThreshold && currentPage > 0 {
                                currentPage -= 1
                            }
                            dragOffset = 0
                        }
                )
        }
        .ignoresSafeArea()
    }
}


#Preview {
    @Previewable @State var page = 0
    @Previewable @State var dragOffset: CGFloat = 0
    SnapPagingView(pageCount: 3, currentPage: $page, dragOffset: $dragOffset) { width, height in
        VStack(spacing: 0) {
            ForEach(0..<3) { index in
                ZStack {
                    Color(hue: Double(index) / 3.0, saturation: 0.8, brightness: 0.9)
                    Text("Page \(index + 1)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(width:width, height:height)
            }
        }
        
    }
}
