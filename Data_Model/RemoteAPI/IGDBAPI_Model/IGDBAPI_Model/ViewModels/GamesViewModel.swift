//
//  GamesViewModel.swift
//  IGDBAPI_Model
//
//  Created by D F on 9/8/25.
//

import Foundation

@Observable
final class GamesViewModel {
    var games:[GamesModel] = []
    var isLoading:Bool = false
    var errorMessage: String?
    
    private let manager = IGDBManager.shared
    
    // Fetch games from IGDB
    func fetchGames(){
        isLoading = true
        errorMessage = nil
        
        let query = """
            fields id, name, slug, summary, url, cover.url, first_release_date, genres.name, rating;
            sort first_release_date desc;
            limit 100;
            """
        
        manager.makeRequest(endpoint: "games", query: query) { [weak self] result  in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        self?.games = try decoder.decode([GamesModel].self, from: data)
                    } catch {
                        self?.errorMessage = "Failed to decode: \(error)"
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
            
        }
        
    }
    
}
