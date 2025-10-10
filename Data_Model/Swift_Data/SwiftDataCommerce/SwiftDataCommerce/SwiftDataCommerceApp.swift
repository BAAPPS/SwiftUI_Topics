//
//  SwiftDataCommerceApp.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/7/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataCommerceApp: App {
    let container: ModelContainer
    init() {
        do {
            container = try ModelContainer(for:
                Address.self, GeoLocation.self, Name.self,
                User.self, Product.self, Rating.self,
                Cart.self, CartItem.self, Order.self, OrderItem.self
            )
        } catch {
            fatalError("Failed to create SwiftData container: \(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
            let context = ModelContext(container)
            ContentView()
                .environment(\.modelContext, context)
        }
    }
}
