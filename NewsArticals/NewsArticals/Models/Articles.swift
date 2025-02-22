//
//  Articles.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 17/11/24.
//

import Foundation

// MARK: - Articles
struct Articles: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    
        private enum CodingKeys: String, CodingKey {
            case status = "status"
            case totalResults = "totalResults"
            case articles = "articles"
        }
}

// MARK: - Article
struct Article: Codable ,Identifiable {
    var id: UUID { UUID() }
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    var nid: UUID?
    
    private enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
        case nid = "id"
    }
    
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
