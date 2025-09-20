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
    let monitor: NetworkMonitorProtocol
    
    init(_ monitor: NetworkMonitorProtocol) {
        self.monitor = monitor
    }
}
