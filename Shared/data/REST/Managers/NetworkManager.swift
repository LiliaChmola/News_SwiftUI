//
//  NetworkManager.swift
//  News
//
//  Created by Lilia Chmola on 20.02.2021.
//

import Foundation
import Alamofire

struct NewsError: Error {
    let message: String
}

class NetworkManager {
    
    private let baseURL = "https://newsapi.org/v2"
    private let apiKey = "1e6671c6dc4042459b3a72e0906d707c"
    private let pageSize = "20"
    
    func fetchNewsWith(keywords: String,
                       sortBy: SortBy,
                       page: Int,
                       compeltion: @escaping (Result<[News], Error>) -> Void) {

        var q = keywords
        if q.isEmpty { // it is requeired field, if is empty we use default value
            q = "News" // - default value
        }
        
        let url = "\(baseURL)/everything?q=\(q)&sortBy=\(sortBy.rawValue)&pageSize=\(pageSize)&page=\(page)&apiKey=\(apiKey)"
    
        AF.request(url)
            .responseJSON { response in
                if let jsonDict = response.value as? [String: Any] {
                    if let articlesDictArray = jsonDict["articles"] as? [[String: Any]] {
                        let newsArray = articlesDictArray.compactMap { News(with: $0) }
                        compeltion(.success(newsArray))
                    }
                } else {
                    compeltion(.failure(NewsError(message: "Error")))
                }
            }
    }
}
