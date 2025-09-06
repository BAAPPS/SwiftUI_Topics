//
//  BooksListView.swift
//  OpenLibraryModel
//
//  Created by D F on 9/2/25.
//

import SwiftUI
import Kingfisher

struct BooksGridView: View {
    @Environment(BooksVM.self) var booksVM
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(booksVM.booksWithCovers) { book in
                    VStack(spacing: 4) {
                        let columnWidth = (UIScreen.main.bounds.width - 16*3)/2
                        
                        ZStack(alignment: .topTrailing) {
                            // Cover image
                            KFImage(book.coverURL)
                                .resizable()
                                .scaledToFill()
                                .frame(width: columnWidth, height: columnWidth * 4/3)
                                .clipped()
                                .cornerRadius(8)
                                .accessibilityLabel("\(book.title) cover image")
                                .accessibilityAddTraits(.isImage)
                            
                            // Info button overlay
                            NavigationLink(value: book) {
                                Image(systemName: "info.circle.fill")
                                    .font(.title2)
                                    .padding(8)
                                    .background(Color.black.opacity(0.6))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                            .padding(6)
                            .accessibilityLabel("Info for \(book.title)")
                            .accessibilityHint("Tap to view book details")
                        }
                        
                        // Book title
                        Text(book.title)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .frame(width: columnWidth, height: 40)
                            .padding(4)
                            .background(Color.black.opacity(0.8))
                            .foregroundColor(Color.white.opacity(0.7))
                            .cornerRadius(10)
                            .accessibilityHidden(true)
                    }
                    .accessibilityElement(children: .contain)
                    
                }
            }
            .padding(16)
        }
        .navigationDestination(for: BookModel.self) { book in
            BooksDetailView(book: book)
        }
        .navigationTitle("Books")
        .navigationBarColor(background: Color.red.opacity(0.9), titleColor: Color.white)
    }
}

#Preview {
    NavigationStack {
        BooksGridView()
            .environment(BooksVM())
    }
}
