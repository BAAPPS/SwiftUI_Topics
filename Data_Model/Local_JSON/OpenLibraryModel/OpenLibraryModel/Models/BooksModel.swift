//
//  BooksModel.swift
//  OpenLibraryModel
//
//  Created by D F on 9/2/25.
//

import Foundation

struct BooksModel: Codable {
    
    let q: String
    let documentationURL: String
    let docs: [BookModel]
    
    enum CodingKeys: String, CodingKey {
        case q, docs
        case documentationURL = "documentation_url"
    }
    
    
    static let response: BooksModel = Bundle.main.decode("CSBooks.json")
    static let allDocs: [BookModel] = response.docs
    static let bookExample = allDocs[0]
    
}
