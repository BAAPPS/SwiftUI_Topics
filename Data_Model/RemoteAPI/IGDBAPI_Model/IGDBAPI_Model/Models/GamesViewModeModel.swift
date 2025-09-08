//
//  GamesViewModeModel.swift
//  IGDBAPI_Model
//
//  Created by D F on 9/8/25.
//

import SwiftUI

@Observable
final class GamesViewModeModel {
    enum ViewMode {
        case grid
        case list
    }

    var currentMode: ViewMode = .grid
}

