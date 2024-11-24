//
//  SDRouter.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 24/11/24.
//

import Alamofire
import Foundation

public enum SDRouter: URLRequestConvertible {
    static let baseAPIVersion = ".npoint.io"
    case groups(forSiteWithID: Int)
    case getPetsData
    
    var method: HTTPMethod {
        switch self {
        case .groups:
            return .get
        case .getPetsData:
            return .get
        }
    }
    
    var path: String {
        switch self {
        
        case .groups(let site_id):
                 return "/site/\(site_id)/groups/"
        case .getPetsData:
            return "/89bc67a9845e640ae6ce"
        }
    }
    
    // MARK: URLRequestConvertible
    
    /// Returns a URL request or throws if an `Error` was encountered.
    ///
    /// - throws: An `Error` if the underlying `URLRequest` is `nil`.
    ///
    /// - returns: A URL request.
    
    public func asURLRequest() throws -> URLRequest  {
        let url = Foundation.URL(string: "" + SDRouter.baseAPIVersion)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .groups:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .getPetsData:
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

