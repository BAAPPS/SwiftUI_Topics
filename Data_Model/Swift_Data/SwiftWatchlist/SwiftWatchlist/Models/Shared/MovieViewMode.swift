//
//  MovieViewMode.swift
//  SwiftWatchlist
//
//  Created by D F on 9/26/25.
//

import SwiftUI

@Observable
final class MovieViewMode{
    enum ViewMode{
        case grid
        case list
        
    }
    
    var currentMode:ViewMode = .list
}
