//
//  NetworkMonitorProtocol.swift
//  Coverr_Model
//
//  Created by D F on 9/20/25.
//

import Foundation
import Network
import Observation


protocol NetworkMonitorProtocol:Observable {
    /// True if the device currently has an active internet connection.
    var isConnected: Bool { get }
    
    /// The type of active connection (Wi-Fi, Cellular, Ethernet, etc.).
    var connectionType: NWInterface.InterfaceType? { get }
}
