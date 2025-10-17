//  SwiftGymTrackerApp.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//

import SwiftUI
import SwiftData
import CloudKit

@main
struct SwiftGymTrackerApp: App {
    let container: ModelContainer
    
    init() {
        do {
            let config: ModelConfiguration
            
#if DEBUG
            // --- DEV MODE: in-memory store for previews / simulator ---
            config = ModelConfiguration(isStoredInMemoryOnly: true)
#else
            // --- PROD MODE ---
            // Check if iCloud account is available
            var useCloudKit = false
            let semaphore = DispatchSemaphore(value: 0)
            CKContainer.default().accountStatus { status, _ in
                useCloudKit = (status == .available)
                semaphore.signal()
            }
            semaphore.wait()
            
            if useCloudKit {
                print("iCloud available: enabling CloudKit sync")
                config = ModelConfiguration(isStoredInMemoryOnly: false, cloudKitDatabase: .automatic)
            } else {
                print("No iCloud account: using local persistent store")
                config = ModelConfiguration(isStoredInMemoryOnly: false)
            }
#endif
            
            // Configure SwiftData container
            container = try ModelContainer(
                for: Exercise.self, Workout.self,
                configurations: config
            )
            
        } catch {
            print("❌ SwiftData container failed to initialize:")
            dump(error)  // prints full error hierarchy
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
