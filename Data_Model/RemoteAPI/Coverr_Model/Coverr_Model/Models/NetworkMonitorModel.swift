//
//  NetworkMonitorModel.swift
//  Coverr_Model
//
//  Created by D F on 9/19/25.
//

import Network
import Observation

@Observable
class NetworkMonitorModel {
    var isConnected: Bool = false
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorModel")
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                let newStatus = path.status == .satisfied
                self?.isConnected = newStatus
                print("🌐 Network status changed → \(newStatus ? "ONLINE ✅" : "OFFLINE ❌")")
            }
        }
        monitor.start(queue: queue)
        
        // Seed initial state
        isConnected = monitor.currentPath.status == .satisfied
        print("📡 NetworkMonitorModel started monitoring (initial: \(isConnected ? "ONLINE ✅" : "OFFLINE ❌"))")
    }
    
    deinit {
        monitor.cancel()
        print("🛑 NetworkMonitorModel stopped monitoring")
    }
}
