//
//  CoverrEndpoints.swift
//  Coverr_Model
//
//  Created by D F on 9/14/25.
//

import Foundation

enum CoverrEndpoints: String, CaseIterable {
    case videos
    case collections
    
    var path: String { rawValue }
}

