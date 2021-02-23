//
//  NewsListVM.swift
//  News
//
//  Created by Lilia Chmola on 21.02.2021.
//

import Foundation
import SwiftUI

class NewsListVM: ObservableObject {
    @Published var news = [News]()
    @Published var selectedSort: String = SortBy.publishedAt.textValue
    @Published var isPresentedDetails: Bool = false
    @Published var selectedItem: News?
    @Published var searchText: String = ""
    let sortedValues: [String] = [SortBy.publishedAt.textValue,
                                  SortBy.relevancy.textValue,
                                  SortBy.popularity.textValue]
    
    private let manager = NewsManager()
        
    func setup() {
        fetchFirstPage()
    }
    
    func fetchFirstPage() {
        manager.fetchFirstPageNews(keywords: searchText,
                                   sortBy: selectedSort) { [weak self] result in
            guard let self = self else { return }
            self.clearNews()
            self.observeResult(result: result)
        }
    }
    
    func fetchNextPage() {
        manager.fetchNextPageNews { [weak self] result in
            guard let self = self else { return }
            self.observeResult(result: result)
        }
    }
    
    private func clearNews() {
        self.news = []
    }
    
    private func observeResult(result: Result<[News], Error>) {
        switch result {
        case .success(let news):
            self.news += news
        case .failure:
            break
        }
    }
    
    func openDetails(with news: News) {
        self.selectedItem = news
        self.isPresentedDetails = true
    }
}
