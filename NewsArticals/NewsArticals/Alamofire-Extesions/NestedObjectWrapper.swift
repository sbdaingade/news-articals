//
//  NestedObjectWrapper.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 24/11/24.
//

import Foundation
internal let codingUserInfoKey = CodingUserInfoKey(rawValue: "codingUserInfoKey")!

enum KeyPathError: Error {
    case emptyPathError
}

public struct NestedObjectWraper<T: Decodable>: Decodable {
    var object: T
    
    public struct Key: CodingKey {
        public init?(intValue: Int) {
            self.intValue = intValue
            stringValue = String(intValue)
        }
        
        public init?(stringValue: String) {
            self.stringValue = stringValue
            intValue = nil
        }
        
        public let intValue: Int?
        public let stringValue: String
    }
    
    typealias KeyedContainer = KeyedDecodingContainer<NestedObjectWraper<T>.Key>
    
    public init(from decoder: Decoder) throws {
        guard let keyPath = decoder.userInfo[codingUserInfoKey] as? [String], !keyPath.isEmpty else {
            throw KeyPathError.emptyPathError
        }
        
        func container(forKeyPath keys: [String], currentContainer: KeyedContainer) throws -> T {
            guard let currentKey = keys.first, let key = Key(stringValue: currentKey) else {
                throw KeyPathError.emptyPathError
            }
            if keys.count > 1 {
                let nestedContainer = try currentContainer.nestedContainer(keyedBy: Key.self, forKey: key)
                return try container(forKeyPath: Array(keys.dropFirst()), currentContainer: nestedContainer)
            }else {
                return try currentContainer.decode(T.self, forKey: key)
            }
        }
        
        let currentContainer = try decoder.container(keyedBy: Key.self)
        object = try container(forKeyPath: keyPath, currentContainer: currentContainer)
    }
}
