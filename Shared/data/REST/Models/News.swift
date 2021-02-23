//
//  News.swift
//  News
//
//  Created by Lilia Chmola on 21.02.2021.
//

import Foundation

struct News: Identifiable, Equatable, Hashable {
    let id = UUID()
    let name: String
    let authorString: String
    let title: String
    let description: String
    let urlToImage: URL
    let url: URL
    let publishedAt: String
    let content: String
    
    init(name: String, authorString: String, title: String, description: String, urlToImage: URL, url: URL, publishedAt: String, content: String) {
        self.name = name
        self.title = title
        self.description = description
        self.urlToImage = urlToImage
        self.url = url
        self.publishedAt = publishedAt
        self.authorString = authorString
        self.content = content
    }
    
    init?(with dict: [String: Any]) {
        guard let sourceDict = dict["source"] as? [String: Any],
              let name = sourceDict["name"] as? String,
              let title = dict["title"] as? String,
              let description = dict["description"] as? String,
              let urlString = dict["url"] as? String,
              let url = URL.init(string: urlString),
              let urlToImageString = dict["urlToImage"] as? String,
              let urlToImage = URL.init(string: urlToImageString),
              let publishedAt = dict["publishedAt"] as? String,
              let authorString = dict["author"] as? String,
              let content = dict["content"] as? String else {
            return nil
        }
        
        self.name = name
        self.title = title
        self.description = description
        self.urlToImage = urlToImage
        self.url = url
        self.publishedAt = publishedAt
        self.authorString = authorString
        self.content = content
    }
}
