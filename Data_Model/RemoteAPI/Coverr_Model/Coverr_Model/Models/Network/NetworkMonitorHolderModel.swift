//
//  NetworkMonitorHolderModel.swift
//  Coverr_Model
//
//  Created by D F on 9/20/25.
//

import Observation

/// Wraps any NetworkMonitorProtocol so it can be used in SwiftUI
/// and observed using `@Observable`.
@Observable
final class NetworkMonitorHolder {
    var monitor: NetworkMonitorProtocol

    init() {
        #if targetEnvironment(simulator)
        // Simulator → always online
        self.monitor = MockNetworkMonitor(isConnected: true)
        #else
        // Device → real NWPathMonitor
        self.monitor = NetworkMonitorModel()
        #endif
    }
    
    // Optional: allow custom injection if needed
    init(_ monitor: NetworkMonitorProtocol) {
        self.monitor = monitor
    }
}
