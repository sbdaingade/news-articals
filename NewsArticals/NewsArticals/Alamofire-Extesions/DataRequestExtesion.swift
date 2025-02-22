//
//  DataRequestExtesion.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 24/11/24.
//

import Alamofire
import Foundation
import Combine

extension DataRequest {
    @discardableResult
    public func responseDecodableObject<T: Decodable>(of type: T.Type = T.self,
                                                      queue: DispatchQueue = .main,
                                                      withKeyPath keyPath: String? = nil,
                                                      decoder: DataDecoder = JSONDecoder(),
                                                      emptyResponseCodes: Set<Int> = DecodableResponseSerializerWithKeyPath<T>.defaultEmptyResponseCodes,
                                                      emptyRequestMethods: Set<HTTPMethod> = DecodableResponseSerializerWithKeyPath<T>.defaultEmptyRequestMethods,
                                                      completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self {
        
        let dataPreprocessor = DecodableResponseSerializerWithKeyPath<T>(keyPath: keyPath, emptyResponseCodes: emptyResponseCodes, emptyRequestMethods: emptyRequestMethods)
        
        return response(queue: queue,
                        responseSerializer: dataPreprocessor,
                        completionHandler: completionHandler)
    }
    
    public func validateResponseData() -> Self {
        return validate { request, response, data in
            switch response.statusCode {
            case 200...299:
               print(String(data: data!, encoding: .utf8)!)
                
                if let jsonString = String(data: data!, encoding: .utf8) {
                    let jsonData = jsonString.data(using: .utf8)!
                    let blogPost: Articles = try! JSONDecoder().decode(Articles.self, from: jsonData)
                    
                    debugPrint("\(blogPost)")

                }
                
                
                return .success(())
            case 401:
                return .success(())
            case 428:
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed) as! [String: Any]
                    return .failure(BackendError.UserCommunicatorErrors.pendingSignatures(jsonData))
                }catch {
                    return .failure(error)
                }
            default:
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed) as! [String: Any]
                    return .failure(BackendError.errorObject(jsonData))
                }catch {
                    if let errorString = String(data: data!, encoding: .utf8) {
                        return .failure(BackendError.errorString(errorString))
                    }
                    return .failure(error)
                }
            }
        }
    }
}
