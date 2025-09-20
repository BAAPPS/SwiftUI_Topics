//
//  NWInterface+Description.swift
//  Coverr_Model
//
//  Created by D F on 9/20/25.
//

import Foundation
import Network

/// Adds a human-readable description for `NWInterface.InterfaceType`.
/// This is used by the Network Monitor to show connection type in the UI.
extension NWInterface.InterfaceType {
    var description: String {
        switch self {
        case .wifi: return "Wi-Fi"
        case .cellular: return "Cellular"
        case .wiredEthernet: return "Ethernet"
        case .loopback: return "Loopback"
        case .other: return "Other"
        @unknown default: return "Unknown"
        }
    }
}
