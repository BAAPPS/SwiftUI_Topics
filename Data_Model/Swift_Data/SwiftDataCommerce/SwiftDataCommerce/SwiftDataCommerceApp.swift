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
#if DEBUG
            // --- DEV MODE ---
            print("Running DEV mode (in-memory store)")
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
#else
            // --- PROD MODE ---
            backupProdStore()
            print("Running PROD mode (persistent default.store)")
            let config = ModelConfiguration(isStoredInMemoryOnly: false)
#endif
            
            // Configure container
            container = try ModelContainer(
                for: Product.self, Rating.self, Cart.self, CartItem.self,
                configurations: config
            )
            
            // Debug store paths
            printSwiftDataStorePaths()
            
        } catch {
            fatalError("Failed to create SwiftData container: \(error)")
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            let context = ModelContext(container)
            ContentView(context: context)
                .environment(\.modelContext, context)
        }
    }
}
