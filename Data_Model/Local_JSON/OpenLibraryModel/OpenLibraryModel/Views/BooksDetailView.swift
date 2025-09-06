//
//  BooksDetailView.swift
//  OpenLibraryModel
//
//  Created by D F on 9/2/25.
//

import SwiftUI
import Kingfisher

struct BooksDetailView: View {
    let book: BookModel
    var body: some View {
        VStack(alignment:.leading, spacing: 10) {
            KFImage(book.coverURL)
                .resizable()
                .accessibilityLabel("\(book.title) cover image")
                .accessibilityAddTraits(.isImage)
            
            
            
            if let subtitle = book.subtitle {
                IconTextRow(systemName: "text.alignleft", text: subtitle.titleCased())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 5)
                
                shortDivider(height: 1, color: Color.black.opacity(0.2))
            }
            
            
            
            if let authors = book.authorNames {
                IconTextRow(systemName: authors.count > 1 ? "person.2.fill" : "person.fill",
                            text: authors.joined(separator: ", ").titleCased())
                .frame(maxWidth:.infinity, alignment: .center)
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
                
                shortDivider(height: 1, color: Color.black.opacity(0.2))
            }
            
            
            HStack(alignment:.center, spacing: 10){
                if let language = book.language {
                    IconTextRow(systemName: "globe", text: language.joined(separator: ", ").titleCased())
                }
                
                shortDivider()
                
                if let publishedYear = book.firstPublishYear {
                    // 1,985  -> 1985
                    IconTextRow(systemName: "calendar", text: "\(String(publishedYear))")
                    
                }
                
            }
            .padding(.horizontal, 40)
            .frame(maxWidth:.infinity, alignment: .center)
            
            
            Spacer()
        }
        .navigationTitle(book.title.titleCased())
        .navigationBarTitleDisplayMode(.inline)
        .backButton()
    }
}

#Preview {
    NavigationStack {
        BooksDetailView(book: BooksModel.bookExample )
    }
    .navigationBarColor(background: Color.red.opacity(0.9), titleColor: Color.white)
}
