//
//  NewsAPIManager.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//

import Foundation

@Observable
final class NewsAPIManager {
    static let shared = NewsAPIManager()
    private let apikey: String
    
    private init() {
        self.apikey = Secrets.apiKey
    }
    
    func makeRequest(
        endpoint: String = "everything",
        query: String = "Netflix",
        page: Int = 1,
        category: TopHeadlineCategory? = nil,
        country: TopHeadlineCountry? = nil,
        completion: @escaping (Result<NewsModel, Error>) -> Void
    ) {
        // Validate query for everything endpoint
        if endpoint == "everything", query.isEmpty {
            completion(.failure(NSError(domain: "Query cannot be empty", code: -1)))
            return
        }
        
        var components = URLComponents(string: "https://newsapi.org/v2/\(endpoint)")
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "apiKey", value: apikey)
        ]
        
        switch endpoint {
        case "everything":
            queryItems.append(URLQueryItem(name: "q", value: query))
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        case "top-headlines":
            if let category = category {
                queryItems.append(URLQueryItem(name: "category", value: category.rawValue))
            }
            if let country = country {
                queryItems.append(URLQueryItem(name: "country", value: country.rawValue))
            }
        default:
            break
        }
        
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -1)))
                return
            }
            
            // Debug: print raw JSON
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON:\n", jsonString)
            }
            
            do {
                // Check API error response
                if let topLevel = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let status = topLevel["status"] as? String,
                   status == "error" {
                    let message = topLevel["message"] as? String ?? "Unknown API error"
                    completion(.failure(NSError(domain: "NewsAPI Error", code: -1, userInfo: ["message": message])))
                    return
                }
                
                // Decode normally
                let news = try JSONDecoder().decode(NewsModel.self, from: data)
                completion(.success(news))
                
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}

