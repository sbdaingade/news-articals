//
//  NewsArticles.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 24/11/24.
//

import Foundation
import Combine
import Alamofire

protocol NewsArticlesCommunicatorProtocol {
    static func getArticlesData(strDate: String) -> AnyPublisher<Articles, AFError>
    static func getWorldStreetJournalArticlesData() -> AnyPublisher<Articles, AFError>
    static func searchArticlesDataUsingPublisher(searchQuery: String) -> AnyPublisher<Articles, AFError>
}

struct DSNewsArticlesCommunicator: NewsArticlesCommunicatorProtocol{
    
    static func getWorldStreetJournalArticlesData() -> AnyPublisher<Articles, Alamofire.AFError> {
        LCProductionSession.default.request(SDRouter.getWorldStreetJournal).validateResponseData().publishDecodable(type: Articles.self).value()
    }
    
    static func getArticlesData(strDate: String) -> AnyPublisher<Articles, AFError> {
        LCProductionSession.default.request(SDRouter.getNewsArticles(strDate)).validateResponseData().publishDecodable(type: Articles.self).value()
    }
    
    static func searchArticlesDataUsingPublisher(searchQuery: String) -> AnyPublisher<Articles, AFError> {
        LCProductionSession.default.request(SDRouter.searchArticles(searchQuery)).validateResponseData().publishDecodable(type: Articles.self).value()
    }
    
}



