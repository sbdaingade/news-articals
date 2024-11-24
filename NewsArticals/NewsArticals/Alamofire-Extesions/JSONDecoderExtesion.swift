//
//  JSONDecoderExtesion.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 24/11/24.
//

import Foundation
import Alamofire

extension JSONDecoder {
    public func decode<T>(_ type: T.Type, from data: Data, withKeyPath keyPath: String?) throws -> T where T : Decodable {
        if let keyPath = keyPath {
            userInfo[codingUserInfoKey] = keyPath.components(separatedBy: ".")
            return try decode(NestedObjectWraper<T>.self, from: data).object
        }
        return try decode(T.self, from: data)
    }
}

extension DataDecoder {
    func decode<D: Decodable>(_ type: D.Type, from data: Data, withKeyPath keyPath: String?) throws -> D {
        return try JSONDecoder().decode(type, from: data, withKeyPath: keyPath)
    }
}
