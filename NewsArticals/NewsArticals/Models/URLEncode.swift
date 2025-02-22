//
//  URLEncode.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 22/02/25.
//
import Foundation

@propertyWrapper
class URLEncode {
    private(set) var value: String = ""
    
    var wrappedValue: String {
        get {return value }
        set {
            if let url = newValue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                self.value = url
            }
        }
    }
}

struct Resource {
    @URLEncode
    var searchData: String
    var url: String {
        "https://newsapi.org/v2/everything?q=\(searchData)&apiKey=4a4a314c16c94996837a2b0c27ccd767"
    }
   
}
extension Resource {
    init(searchData: String) {
        self.searchData = searchData
    }
}
