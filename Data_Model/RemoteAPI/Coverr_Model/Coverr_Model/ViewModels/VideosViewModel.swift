//
//  VideosViewModel.swift
//  Coverr_Model
//
//  Created by D F on 9/14/25.
//

import Foundation

@MainActor
@Observable
class VideosViewModel {
    private let manager = CoverrAPIManager.shared
    private let maxPages = 25
    
    // MARK: - All Videos
    var allVideos: [VideoHitsModel] = []
    private var currentPage = 0
    
    // MARK: - Collections
    var allCollections: [VideoHitsModel] = []
    private var collectionsPage = 0
    
    var allCollectionsVideo: [VideoHitsModel] = []
    private var collectionsVideoPage = 1
    
    // Track fetched video IDs to prevent duplicates
    private var fetchedVideoIDs = Set<String>()
    
    
    // MARK: - Loading / Errors
    var isLoading: Bool = false
    var errorMessage: String?
    
    // MARK: - Fetch All Videos
    func fetchVideos(reset: Bool = false) async {
        if reset {
            currentPage = 0
            allVideos = []
            errorMessage = nil
        }
        await fetchVideosNextPage()
    }
    
    func fetchVideosNextPage() async {
        guard !isLoading, currentPage < maxPages else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            let videosModel = try await manager.fetchVideosAsync(page: currentPage)
            allVideos.append(contentsOf: videosModel.hits)
            currentPage += 1
        } catch let apiError as APIError {
            errorMessage = apiError.errorDescription
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - Fetch All Collections
    func fetchCollections(reset: Bool = false) async {
        if reset {
            collectionsPage = 0
            allCollections = []
            errorMessage = nil
        }
        await fetchCollectionsNextPage()
    }
    
    func fetchCollectionsNextPage() async {
        guard !isLoading, collectionsPage < maxPages else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            let collectionsModel = try await manager.fetchVideosAsync(
                endpoint: .collections,
                page: collectionsPage
            )
            allCollections.append(contentsOf: collectionsModel.hits)
            collectionsPage += 1
        } catch let apiError as APIError {
            errorMessage = apiError.errorDescription
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - Fetch Videos for a Specific Collection Concurrently
    
    @MainActor
    func fetchAllCollectionsVideosConcurrently(reset: Bool = false) async {
        if reset {
            collectionsVideoPage = 1
            allCollectionsVideo = []
            fetchedVideoIDs.removeAll()
            errorMessage = nil
        }
        
        guard !allCollections.isEmpty else { return }
        
        await withTaskGroup(of: (collectionID: String, videos: [VideoHitsModel]).self) { group in
            for collection in allCollections {
                group.addTask {
                    var page = 1
                    let maxPages = 25
                    var allVideosForCollection: [VideoHitsModel] = []
                    
                    while page <= maxPages {
                        do {
                            let videosModel = try await self.manager.fetchVideosAsync(
                                endpoint: .collections,
                                page: page,
                                collectionID: collection.id
                            )
                            if videosModel.hits.isEmpty { break }
                            allVideosForCollection.append(contentsOf: videosModel.hits)
                            page += 1
                        } catch {
                            break
                        }
                    }
                    
                    return (collectionID: collection.id, videos: allVideosForCollection)
                }
            }
            
            for await result in group {
                // Safely update main-actor properties in one place
                let newVideos = result.videos.filter { !fetchedVideoIDs.contains($0.id) }
                newVideos.forEach { fetchedVideoIDs.insert($0.id) }
                allCollectionsVideo.append(contentsOf: newVideos)
            }
        }
    }


}
