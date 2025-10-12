//
//  AppTab.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/12/25.
//

import Foundation

enum AppTab: Int, CaseIterable, Identifiable {
    case home
    case cart
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .cart:
            return "Cart"
        }
    }
    
    var icons: String {
        switch self {
        case .home:
            return "house.fill"
            
        case .cart:
            return "cart.fill"
        }
    }
}
