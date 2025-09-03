//
//  BooksDetailView.swift
//  OpenLibraryModel
//
//  Created by D F on 9/2/25.
//

import SwiftUI

struct BooksDetailView: View {
    let book: BookModel
    var body: some View {
        Text(book.title)
    }
}

#Preview {
    BooksDetailView(book: BooksModel.bookExample )
}
