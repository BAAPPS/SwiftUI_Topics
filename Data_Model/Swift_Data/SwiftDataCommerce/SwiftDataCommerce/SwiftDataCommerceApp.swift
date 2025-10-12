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
            // --- DEV MODE (persistent for learning) ---
            // Previously used in-memory store for testing (did NOT persist).
            //  let config = ModelConfiguration(isStoredInMemoryOnly: true)
            // Now using persistent store to keep data between app launches.
            // Files created: default.store, default.store-shm, default.store-wal
            let config = ModelConfiguration(isStoredInMemoryOnly: false)
#else
            // --- PROD MODE ---
            // Ensure backup of existing production store before loading
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
