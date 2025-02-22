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
    static func getArticlesData() -> AnyPublisher<Articles, AFError>
}

struct DSNewsArticlesCommunicator: NewsArticlesCommunicatorProtocol{
    static func getArticlesData() -> AnyPublisher<Articles, AFError> {
        LCProductionSession.default.request(SDRouter.getNewsArticles).validateResponseData().publishDecodable(type: Articles.self).value()
    }
    
    
    //static func getArticlesDataUsingPublisher() 
    
    
    
    
}



