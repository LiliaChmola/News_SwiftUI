//
//  NewsManager.swift
//  News
//
//  Created by Lilia Chmola on 21.02.2021.
//

import Foundation

enum SortBy: String {
    case relevancy
    case popularity
    case publishedAt
    
    var textValue: String {
        switch self {
        case .relevancy:
            return "Relevancy"
        case .popularity:
            return "Popularity"
        case .publishedAt:
            return "Published at"
        }
    }
    
    init(textValue: String) {
        switch textValue {
        case "Relevancy":
            self = .relevancy
        case "Popularity":
            self = .popularity
        case "Published at":
            self = .publishedAt
        default:
            self = .publishedAt
        }
    }
}

class SearchParams {
    var keywords: String = ""
    var sortBy: String = SortBy.publishedAt.rawValue
    var page = 1
    var isLoading = false
    
    func reset() {
        page = 1
        stopLoading()
    }
    
    func startLoading() {
        isLoading = true
    }
    
    func stopLoading() {
        isLoading = false
    }
}

class NewsManager {
    private let networkManager = NetworkManager()
    private var searchParams = SearchParams()
    
    func fetchFirstPageNews(keywords: String,
                            sortBy: String,
                            compeltion: @escaping (Result<[News], Error>) -> Void) {
        guard !searchParams.isLoading else { return }
        
        searchParams.keywords = keywords
        searchParams.sortBy = sortBy
        searchParams.page = 1
        searchParams.startLoading()
        
        networkManager.fetchNewsWith(keywords: keywords,
                                     sortBy: SortBy(textValue: sortBy),
                                     page: searchParams.page) { [weak self] (result) in
            guard let self = self else { return }
            self.observeResult(result: result)
            compeltion(result)
        }
    }
    
    func fetchNextPageNews(compeltion: @escaping (Result<[News], Error>) -> Void) {
        guard !searchParams.isLoading else { return }
        
        searchParams.page += 1
        searchParams.startLoading()

        networkManager.fetchNewsWith(keywords: searchParams.keywords,
                                     sortBy: SortBy(textValue: searchParams.sortBy),
                                     page: searchParams.page) { [weak self] (result) in
            guard let self = self else { return }
            self.observeResult(result: result)
            compeltion(result)
        }
    }
    
    private func observeResult(result: Result<[News], Error>) {
        switch result {
        case .success:
            self.searchParams.stopLoading()
        case .failure:
            self.searchParams.reset()
        }
    }
}
