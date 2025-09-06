//
//  BookModel.swift
//  OpenLibraryModel
//
//  Created by D F on 9/2/25.
//

import Foundation

struct BookModel: Codable, Identifiable, Hashable {
    var id: String { key }
    let authorKeys: [String]?
    let authorNames: [String]?
    let coverEditionKey: String?
    let coverI: Int?
    let editionCount:Int?
    let firstPublishYear: Int?
    let key: String
    let language: [String]?
    let title: String
    let subtitle: String?
    
    enum CodingKeys: String, CodingKey {
        case authorKeys = "author_key"
        case authorNames = "author_name"
        case coverEditionKey =  "cover_edition_key"
        case coverI = "cover_i"
        case editionCount = "edition_count"
        case firstPublishYear = "first_publish_year"
        case key, language, title, subtitle
    }
    
    
    // Computed property for cover URL with fallback
    var coverURL: URL? {
        if let coverEditionKey {
            return URL(string: "https://covers.openlibrary.org/b/olid/\(coverEditionKey)-L.jpg")
        } else if let coverI {
            return URL(string: "https://covers.openlibrary.org/b/id/\(coverI)-L.jpg")
        } else {
            return nil
        }
    }
}
