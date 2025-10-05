//
//  MovieViewMode+Transition.swift
//  SwiftWatchlist
//
//  Created by D F on 10/5/25.
//

import SwiftUI

extension MovieViewMode.ViewMode {
    func transition() -> AnyTransition {
        .asymmetric(
            insertion: .move(edge: self == .list ? .trailing : .leading).combined(with: .opacity),
            removal: .move(edge: self == .list ? .leading : .trailing).combined(with: .opacity))
    }
}
