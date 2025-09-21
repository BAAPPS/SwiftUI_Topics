//
//  AppTab.swift
//  Coverr_Model
//
//  Created by D F on 9/21/25.
//

import Foundation

enum AppTab: Int, CaseIterable, Identifiable {
    case all
    case collection
    var id: Int {rawValue}
    
    var title: String {
        switch self {
        case .all:  return "All Videos"
        case .collection: return  "Collections"
            
        }
    }
    
    var icons: String {
        switch self {
        case .all:  return "globe"
        case .collection: return  "square.stack"
        }
    }
}
