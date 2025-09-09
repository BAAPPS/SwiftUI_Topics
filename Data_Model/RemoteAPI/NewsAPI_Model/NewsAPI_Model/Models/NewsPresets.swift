//
//  NewsQueries.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import Foundation

enum NewsQueries: String, CaseIterable {
    case netflix = "Netflix"
    case apple = "Apple"
    case tesla = "Tesla"
}

enum TopHeadlineCategory: String, CaseIterable {
    case business, entertainment, health, science, sports, technology
}

enum TopHeadlineCountry: String, CaseIterable {
    case us, gb, ca, au // add more as needed
}
