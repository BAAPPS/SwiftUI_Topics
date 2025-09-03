//
//  BooksVM.swift
//  OpenLibraryModel
//
//  Created by D F on 9/2/25.
//

import Foundation

@Observable
class BooksVM {
    var booksWithCovers: [BookModel] = []

    init() {
        loadBooks()
    }

    private func loadBooks() {
        // Filter all books that have a valid cover URL (either coverEditionKey or coverI)
        booksWithCovers = BooksModel.allDocs.filter {$0.coverURL != nil}
    }
}
