//
//  DevStoreHelpers.swift
//  SwiftDataCommerce
//
//  Created by D F on 10/12/25.
//

import Foundation

func printSwiftDataStorePaths() {
    let fileManager = FileManager.default
    guard let libraryDir = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return }
    
    print("Application Support directory: \(libraryDir.path)")
    ["default.store", "default.store-shm", "default.store-wal"].forEach { filename in
        let fileURL = libraryDir.appendingPathComponent(filename)
        print(fileManager.fileExists(atPath: fileURL.path) ? "Found: \(fileURL.path)" : "Not found: \(fileURL.path)")
    }
}


/// Remove old dev store (only safe in dev)
func removeOldSwiftDataStoreIfNeeded() {
    let fileManager = FileManager.default
    guard let libraryDir = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return }

    ["default.store", "default.store-shm", "default.store-wal"].forEach { filename in
        let url = libraryDir.appendingPathComponent(filename)
        if fileManager.fileExists(atPath: url.path) {
            try? fileManager.removeItem(at: url)
            print("Deleted old store: \(url.path)")
        }
    }
}

/// Backup prod store before overwriting
func backupProdStore() {
    let fileManager = FileManager.default
    guard let libraryDir = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
    let timestamp = dateFormatter.string(from: Date())

    ["default.store", "default.store-shm", "default.store-wal"].forEach { filename in
        let src = libraryDir.appendingPathComponent(filename)
        if fileManager.fileExists(atPath: src.path) {
            let dest = libraryDir.appendingPathComponent("backup_\(timestamp)_\(filename)")
            do {
                try fileManager.copyItem(at: src, to: dest)
                print("Backed up \(filename) → \(dest.lastPathComponent)")
            } catch {
                print("Failed to backup \(filename): \(error)")
            }
        }
    }
}
