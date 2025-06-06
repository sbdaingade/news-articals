//
//  SDRouter.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 24/11/24.
//

import Alamofire
import Foundation

struct CommonConstants {

   
    static func dateFromWebtoApp() -> String {
        let ddate = Calendar.current.date(byAdding: .day, value: -15, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: ddate)
    }
    
}

public enum SDRouter: URLRequestConvertible {
    static let baseAPIVersion = "https://newsapi.org/v2/everything?q=India&from=\(CommonConstants.dateFromWebtoApp())&sortBy=publishedAt&apiKey=4a4a314c16c94996837a2b0c27ccd767"
    case groups(forSiteWithID: Int)
    case getPetsData
    case getNewsArticles(String)
    case getWorldStreetJournal
    case searchArticles(String)
    var method: HTTPMethod {
        switch self {
        case .groups:
            return .get
        case .getPetsData:
            return .get
        case .getNewsArticles:
            return .get
        case .getWorldStreetJournal:
            return .get
        case .searchArticles(_):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .groups(let site_id):
                 return "/site/\(site_id)/groups/"
        case .getPetsData:
            return "/89bc67a9845e640ae6ce"
        case .getNewsArticles(let date):
            return ""
         //   return "https://newsapi.org/v2/everything?q=tesla&from=\(date)&sortBy=publishedAt&apiKey=4a4a314c16c94996837a2b0c27ccd767"
        case .getWorldStreetJournal:
            return "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=4a4a314c16c94996837a2b0c27ccd767"
        case .searchArticles(let query):
            return "https://newsapi.org/v2/everything?q=\(query)&sortBy=publishedAt&apiKey=4a4a314c16c94996837a2b0c27ccd767"

        }
    }
    
    // MARK: URLRequestConvertible
    
    /// Returns a URL request or throws if an `Error` was encountered.
    ///
    /// - throws: An `Error` if the underlying `URLRequest` is `nil`.
    ///
    /// - returns: A URL request.
    
    public func asURLRequest() throws -> URLRequest  {
        var url = Foundation.URL(string: SDRouter.baseAPIVersion)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .groups:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .getPetsData:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .getNewsArticles:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .getWorldStreetJournal:
            url = Foundation.URL(string: "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=4a4a314c16c94996837a2b0c27ccd767")!
            urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .searchArticles(let query):
            url = Foundation.URL(string: "https://newsapi.org/v2/everything?q=\(query)&sortBy=publishedAt&apiKey=4a4a314c16c94996837a2b0c27ccd767")!
            urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        }
        return urlRequest
    }
}

public struct Custom: ParameterEncoding {
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = urlRequest.urlRequest
        let data = try JSONSerialization.data(withJSONObject: parameters!["zone_ids"] as Any, options: [])
        urlRequest?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest?.httpBody = data
        return (urlRequest)!
    }
}

