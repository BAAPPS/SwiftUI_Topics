//
//  NewsViewModel.swift
//  NewsAPI_Model
//
//  Created by D F on 9/9/25.
//


import Foundation

@Observable
final class NewsViewModel {
    // MARK: - Everything News
    var allArticles: [ArticleModel] = []
    private var allCurrentPage = 1
    
    // MARK: - Top Headlines
    var topHeadlines: [ArticleModel] = []
    private var topCurrentPage = 1
    
    // MARK: - Loading / Errors
    var isLoading: Bool = false
    var errorMessage: String?

    private let manager = NewsAPIManager.shared
    private let maxPages = 5
    
    // MARK: - Search / Query
    var queryText: String = "Netflix" {
        didSet { fetchAll(reset: true) }
    }

    var queryPreset: NewsQueries? {
        didSet {
            if let preset = queryPreset {
                queryText = preset.rawValue
            }
        }
    }
    
    // MARK: - Top Headlines Filters
    var topHeadlineCategory: TopHeadlineCategory? = nil {
        didSet { fetchTopHeadlines(reset: true) }
    }
    
    var topHeadlineCountry: TopHeadlineCountry? = .us {
        didSet { fetchTopHeadlines(reset: true) }
    }

    // MARK: - Debouncer
    private var searchWorkItem: DispatchWorkItem?
    private let debounceInterval: TimeInterval = 0.5

    // MARK: - Fetch Everything News
    func fetchAll(reset: Bool = false) {
        if reset {
            allCurrentPage = 1
            allArticles = []
        }
        fetchAllNextPage()
    }

    func fetchAllNextPage() {
        guard !queryText.isEmpty else { return }
        guard allCurrentPage <= maxPages, !isLoading else { return }

        isLoading = true
        errorMessage = nil

        manager.makeRequest(
            endpoint: NewsEndpoint.everything.rawValue,
            query: queryText,
            page: allCurrentPage,
            category: nil,
            country: nil
        ) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let news):
                    self.allArticles.append(contentsOf: news.articles)
                    self.allCurrentPage += 1
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: - Fetch Top Headlines
    func fetchTopHeadlines(reset: Bool = false) {
        if reset {
            topCurrentPage = 1
            topHeadlines = []
        }
        fetchTopNextPage()
    }
    
    func fetchTopNextPage() {
        guard topCurrentPage <= maxPages, !isLoading else { return }

        isLoading = true
        errorMessage = nil

        manager.makeRequest(
            endpoint: NewsEndpoint.topHeadlines.rawValue,
            query: "",
            page: topCurrentPage,
            category: topHeadlineCategory,
            country: topHeadlineCountry
        ) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let news):
                    self.topHeadlines.append(contentsOf: news.articles)
                    self.topCurrentPage += 1
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: - Debounce search
    func debounceSearch() {
        searchWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in
            self?.fetchAll(reset: true)
        }
        searchWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + debounceInterval, execute: workItem)
    }

    // MARK: - Pagination Check
    var hasMoreAllPages: Bool { allCurrentPage <= maxPages }
    var hasMoreTopPages: Bool { topCurrentPage <= maxPages }
}
