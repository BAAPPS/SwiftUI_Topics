//
//  APIErrorManager.swift
//  Coverr_Model
//
//  Created by D F on 9/14/25.
//

import Foundation


enum APIError: Error, LocalizedError {
    case emptyQuery
    case invalidURL
    case requestFailed
    case decodingFailed(String)   
    case receivedNoData
    case serverMessage(String)
    
    var errorDescription: String? {
        switch self {
        case .emptyQuery:
            return "Query cannot be empty."
        case .invalidURL:
            return "The URL is invalid."
        case .requestFailed:
            return "The request failed. Please try again."
        case .decodingFailed(let message):
            return "Failed to decode server response: \(message)"
        case .receivedNoData:
            return "No data was received from the server."
        case .serverMessage(let message):
            return message
        }
    }
}
