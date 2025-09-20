//
//  NetworkMockModel.swift
//  Coverr_Model
//
//  Created by D F on 9/20/25.
//

import Foundation
import Network
import Observation


/// Mock implementation of `NetworkMonitorProtocol`.
///
/// Useful for:
/// - SwiftUI previews
/// - UI tests
/// - Simulating different network states without real devices
@Observable
final class MockNetworkMonitor: NetworkMonitorProtocol {
    var isConnected: Bool
    var connectionType: NWInterface.InterfaceType?

    /// Create a mock monitor with custom state.
    /// - Parameters:
    ///   - isConnected: Whether the network should be "online".
    ///   - connectionType: The simulated connection type (e.g., `.wifi`, `.cellular`).
    init(isConnected: Bool = true, connectionType: NWInterface.InterfaceType? = .wifi) {
        self.isConnected = isConnected
        self.connectionType = connectionType
    }
}
