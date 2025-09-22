//
//  VideosViewModel.swift
//  Coverr_Model
//
//  Created by D F on 9/14/25.
//

import Foundation
import SwiftData

@MainActor
@Observable
class VideosViewModel {
    private let manager = CoverrAPIManager.shared
    private let maxPages = 25
    
    
     var context: ModelContext
     
     init(context: ModelContext) {
         self.context = context
     }
    
    // MARK: - All Videos
    var allVideos: [VideoHitsModel] = []
    private var currentPage = 0
    
    // MARK: - Collections
    var allCollections: [CollectionHitModel] = []
    private var collectionsPage = 0
    
    var allCollectionsVideo: [CollectionVideoModel] = []
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
            let videosModel = try await manager.fetchVideosAsync(page: currentPage, urls: true)
            allVideos.append(contentsOf: videosModel.hits)
            currentPage += 1
            
            
            // Save to SwiftData
            for hit in videosModel.hits {
                let descriptor = FetchDescriptor<VideoEntityModel>(
                    predicate: #Predicate { $0.id == hit.id }
                )
                
                if let _ = try? context.fetch(descriptor).first {
                    continue // skip duplicates
                }
                
                let videoEntity = VideoEntityModel(from: hit)
                if let urls = videoEntity.urls {
                    context.insert(urls)
                }
                context.insert(videoEntity)
            }
            
            try context.save()
            
            
            
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
            let collectionsModel = try await manager.fetchCollectionAsync(
                endpoint: .collections,
                page: collectionsPage,
            )
            allCollections.append(contentsOf: collectionsModel.hits)
            collectionsPage += 1
            
            
            for collection in collectionsModel.hits  {
                let descriptor = FetchDescriptor<CollectionEntityModel>(
                    predicate: #Predicate {$0.id == collection.id}
                )
                
                if let _ = try? context.fetch(descriptor).first {continue}
                
                let entity = CollectionEntityModel(from: collection)
                
                context.insert(entity)
            }
            
            try context.save()
            
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
                                urls: true,
                                collectionID: collection.id,
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
                let collectionVideos = newVideos.map { CollectionVideoModel(collectionID: result.collectionID, video: $0) }
                allCollectionsVideo.append(contentsOf: collectionVideos)

                // Save new collection videos to SwiftData
                for hit in newVideos {
                    let descriptor = FetchDescriptor<VideoEntityModel>(
                        predicate: #Predicate { $0.id == hit.id }
                    )
                    if let _ = try? context.fetch(descriptor).first { continue }
                    
                    let videoEntity = VideoEntityModel(from: hit)
                    if let urls = videoEntity.urls {
                        context.insert(urls)
                    }
                    context.insert(videoEntity)
                }
            }
            
            try? context.save()
        }
    }
    
    func fetchVideosForCollection(collectionID: String) async -> [VideoHitsModel] {
        var page = 1
        let maxPages = 25
        var videosForCollection: [VideoHitsModel] = []

        while page <= maxPages {
            do {
                let videosModel = try await self.manager.fetchVideosAsync(
                    endpoint: .collections,
                    page: page,
                    urls:true,
                    collectionID: collectionID
                )
                if videosModel.hits.isEmpty { break }
                videosForCollection.append(contentsOf: videosModel.hits)
                page += 1
            } catch {
                break
            }
        }

        // Deduplicate with fetchedVideoIDs
        let newVideos = videosForCollection.filter { !self.fetchedVideoIDs.contains($0.id) }
        newVideos.forEach { self.fetchedVideoIDs.insert($0.id) }

        return newVideos
    }

    
    // MARK: - Load Offline Videos
    func loadOfflineVideos() async {
        do {
            let cachedVideos = try context.fetch(FetchDescriptor<VideoEntityModel>())
            let mappedVideos = cachedVideos.map { VideoHitsModel(from: $0) }
            
            // Deduplicate by ID
            allVideos = Array(
                Dictionary(uniqueKeysWithValues: mappedVideos.map { ($0.id, $0) }).values
            )
            
            print("Loaded \(allVideos.count) offline videos")
        } catch {
            print("Failed to load offline videos:", error)
        }
    }

    // MARK: - Load Offline Collection Videos
    func loadOfflineCollections() async {
        do {
            let cachedCollections = try context.fetch(FetchDescriptor<CollectionEntityModel>())
            let mappedCollections = cachedCollections.map { CollectionHitModel(from: $0) }
            
            // Deduplicate by ID
            allCollections = Array(
                Dictionary(uniqueKeysWithValues: mappedCollections.map { ($0.id, $0) }).values
            )
            
            print("Loaded \(allCollections.count) offline collections")
        } catch {
            print("Failed to load offline collections:", error)
        }
    }

    
    func loadVideosDependingOnNetwork(isConnected: Bool) async {
         if isConnected {
             await fetchVideos(reset: true)
         } else {
             await loadOfflineVideos()
         }
     }
    
    func loadCollectionsDependingOnNetwork(isConnected: Bool) async {
        if isConnected {
            await fetchCollections(reset: true)
        } else {
            await loadOfflineCollections()
        }
    }

    
}


@MainActor
extension VideosViewModel {
    func testSwiftData() {
        do {
            let cachedVideos = try context.fetch(FetchDescriptor<VideoEntityModel>())
            print("✅ SwiftData stored \(cachedVideos.count) videos")
            for video in cachedVideos {
                print("Video title:", video.title, "ID:", video.id)
            }
        } catch {
            print("❌ Failed to fetch videos from SwiftData:", error)
        }
    }
}
