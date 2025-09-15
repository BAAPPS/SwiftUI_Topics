//
//  CoverrAPIManager.swift
//  Coverr_Model
//
//  Created by D F on 9/14/25.
//


import Foundation

// MARK: - Top-level API response for error checking
struct APIResponseStatus: Decodable {
    let status: String?
    let message: String?
}

// MARK: - Coverr API Manager
@Observable
final class CoverrAPIManager {
    static let shared = CoverrAPIManager()
    private let apiKey: String
    
    private init() {
        self.apiKey = Secrets.apiKey
    }
    
    // MARK: - Legacy Completion Handler Version
    // This version uses Result<T, APIError> and is kept for reference while we adopt async/await.
    func fetchVideos(
        endpoint: CoverrEndpoints = .videos,
        query: String = "",
        page: Int? = nil,
        pageSize: Int = 20,
        urls: Bool = false,
        sort: String? = nil,
        collectionID: String? = nil,
        completion: @escaping (Result<VideosModel, APIError>) -> Void
    ) {
        Task {
            do {
                let videos = try await fetchVideosAsync(
                    endpoint: endpoint,
                    query: query,
                    page: page,
                    pageSize: pageSize,
                    urls: urls,
                    sort: sort,
                    collectionID: collectionID
                )
                DispatchQueue.main.async {
                    completion(.success(videos))
                }
            } catch let apiError as APIError {
                DispatchQueue.main.async {
                    completion(.failure(apiError))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.serverMessage(error.localizedDescription)))
                }
            }
        }
    }
    
    // MARK: - Async/Await Version
    func fetchVideosAsync(
        endpoint: CoverrEndpoints = .videos,
        query: String = "",
        page: Int? = nil,
        pageSize: Int = 20,
        urls: Bool = false,
        sort: String? = nil,
        collectionID: String? = nil
    ) async throws -> VideosModel {
        
        // Determine default page
        let finalPage: Int
        switch endpoint {
        case .videos: finalPage = page ?? 0
        case .collections: finalPage = page ?? 1
        }
        
        // Build URL string
        let urlString: String
        switch endpoint {
        case .videos:
            urlString = "https://api.coverr.co/\(endpoint.path)"
        case .collections:
            if let id = collectionID, !id.isEmpty {
                // Specific collection videos
                urlString = "https://api.coverr.co/collections/\(id)/videos"
            } else {
                // Full collections list
                urlString = "https://api.coverr.co/collections"
            }
        }
        
        var components = URLComponents(string: urlString)
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "urls", value: urls ? "true" : "false"),
            URLQueryItem(name: "page", value: "\(finalPage)"),
            URLQueryItem(name: "page_size", value: "\(pageSize)")
        ]
        if !query.isEmpty {
            queryItems.append(URLQueryItem(name: "query", value: query))
        }
        if endpoint == .videos, let sort = sort {
            queryItems.append(URLQueryItem(name: "sort", value: sort))
        }
        components?.queryItems = queryItems
        
        guard let url = components?.url else { throw APIError.invalidURL }
        
        // ✅ Debug print full request URL with query items
        print("➡️ Final request URL:", url.absoluteString)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // Debug: print raw JSON first 50 chars
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Raw JSON:\n", jsonString)
        }
        
        // Decode top-level status first to catch server errors
        if let apiStatus = try? JSONDecoder().decode(APIResponseStatus.self, from: data),
           let status = apiStatus.status, status == "error" {
            let message = apiStatus.message ?? "Unknown API error"
            throw APIError.serverMessage(message)
        }
        
        // Decode the main VideosModel with detailed decoding error messages + JSON snippet
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            decoder.dateDecodingStrategy = UniversalDateDecoder.decodingStrategy
            let videos = try decoder.decode(VideosModel.self, from: data)
            return videos
        } catch let decodingError as DecodingError {
            var message: String
            switch decodingError {
            case .typeMismatch(let type, let context):
                message = "Type mismatch for type \(type) at \(context.codingPath.map(\.stringValue).joined(separator: "->")): \(context.debugDescription)"
            case .valueNotFound(let type, let context):
                message = "Value not found for type \(type) at \(context.codingPath.map(\.stringValue).joined(separator: "->")): \(context.debugDescription)"
            case .keyNotFound(let key, let context):
                message = "Key '\(key.stringValue)' not found at \(context.codingPath.map(\.stringValue).joined(separator: "->")): \(context.debugDescription)"
            case .dataCorrupted(let context):
                message = "Data corrupted at \(context.codingPath.map(\.stringValue).joined(separator: "->")): \(context.debugDescription)"
            @unknown default:
                message = "Unknown decoding error: \(decodingError.localizedDescription)"
            }
            
            // Include a small snippet of the JSON where the error happened
            let jsonSnippet: String
            if let snippet = String(data: data, encoding: .utf8) {
                jsonSnippet = snippet.prefix(500) + "..." // first 500 chars
            } else {
                jsonSnippet = "Could not extract JSON snippet"
            }
            
            throw APIError.decodingFailed("\(message)\nJSON snippet: \(jsonSnippet)")
        } catch {
            throw APIError.decodingFailed(error.localizedDescription)
        }
    }
}
