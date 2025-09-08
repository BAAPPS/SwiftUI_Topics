//
//  IGDBManager.swift
//  IGDBAPI_Model
//
//  Created by D F on 9/8/25.
//

import Foundation

@Observable
final class IGDBManager {
    static let shared = IGDBManager()  // singleton for easy access
    private let clientID: String
    private let accessToken:String
    
    private init() {
        self.clientID = Secrets.igdbClientID
        self.accessToken = Secrets.igdbAccessToken
    }
    
    
    func makeRequest(endpoint:String, query: String, completion: @escaping (Result<Data, Error>) -> Void ) {
        let url = URL(string: "https://api.igdb.com/v4/\(endpoint)")!
        var request =  URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.addValue(clientID, forHTTPHeaderField: "Client-ID")
        request.httpBody = query.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error  = error { completion(.failure(error)); return }
            guard let data = data else { completion(.failure(NSError(domain: "NoData", code: -1))); return }
            completion(.success(data))
        }.resume()
    }
    
}
