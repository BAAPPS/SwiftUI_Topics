//
//  NetworkMonitorModel.swift
//  Coverr_Model
//
//  Created by D F on 9/19/25.
//

import Network
import Observation

/// Production-ready implementation of `NetworkMonitorProtocol`.
///
/// Uses Apple's `NWPathMonitor` to detect:
/// - Online/offline state
/// - Type of active network connection
///
/// Updates SwiftUI views automatically using `@Observable`.
@Observable
final class NetworkMonitorModel: NetworkMonitorProtocol {
    /// NWPathMonitor instance for monitoring network changes
    private let monitor = NWPathMonitor()
    
    /// Serial queue for background monitoring work
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    /// True if the device is currently connected to a network
    var isConnected: Bool = false
    
    /// Type of the current connection (Wi-Fi, Cellular, etc.)
    var connectionType: NWInterface.InterfaceType?
    
    /// Initializes and starts monitoring immediately
    init() {
        // Listen for path updates
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                self?.connectionType = self?.extractConnectionType(from: path)
                
                // Debug logging (safe to remove in production)
                print("🌐 Network: \(self?.isConnected == true ? "ONLINE ✅" : "OFFLINE ❌")")
                if let type = self?.connectionType {
                    print("📶 Connection Type: \(type.description)")
                }
            }
        }
        
        // Start background monitoring
        monitor.start(queue: queue)
        
        // Seed initial state
        isConnected = monitor.currentPath.status == .satisfied
        connectionType = extractConnectionType(from: monitor.currentPath)
    }
    
    /// Extracts the active interface type from a given network path
    private func extractConnectionType(from path: NWPath) -> NWInterface.InterfaceType? {
        for interface in path.availableInterfaces {
            if path.usesInterfaceType(interface.type) {
                return interface.type
            }
        }
        return nil
    }
    
    /// Stop monitoring when deinitialized
    deinit {
        monitor.cancel()
    }
}
