//
//  AppTab.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import SwiftUI

enum AppTab: Int, CaseIterable, Identifiable {
    case all
    case topHeadlines
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .all: return "All"
        case .topHeadlines : return "Headlines"
        }
    }
    
    var systemIcon: String {
        switch self {
        case .all: return "newspaper"
        case .topHeadlines: return "megaphone"
        }
    }
}
