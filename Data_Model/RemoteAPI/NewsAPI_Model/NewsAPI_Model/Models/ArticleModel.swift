//
//  ArticleModel.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import Foundation

struct ArticleModel: Codable, Identifiable, Hashable {
    var id: String { url }  // stable identifier
    
    let source: SourceModel
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    struct SourceModel: Codable, Hashable {
        let id: String?
        let name: String
    }
}

extension ArticleModel {
    static let mock = ArticleModel(
        source: ArticleModel.SourceModel(id: "cnn", name: "CNN"),
        author: "Jane Doe",
        title: "SwiftUI News App in Action",
        description: "A detailed look at how to build a news app with SwiftUI and NewsAPI.",
        url: "https://www.example.com",
        urlToImage: "https://picsum.photos/400/200",
        publishedAt: "2025-09-09T12:00:00Z",
        content: "Sample article content for previews and testing."
    )
}
