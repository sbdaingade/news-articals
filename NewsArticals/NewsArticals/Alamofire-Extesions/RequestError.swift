//
//  RequestError.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 24/11/24.
//

import Foundation

public enum BackendError {
    case errorObject([String: Any])
    case errorString(String)
    
    public enum UserCommunicatorErrors {
        case retrievingUserData
        case pendingSignatures([String: Any])
    }
}

extension BackendError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .errorObject(let dict):
            let message = dict.values.map{"\($0)".capitalized}
            return message.joined(separator: "\n")
        case .errorString(let error):
            return error
        }
    }
}

extension BackendError.UserCommunicatorErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .retrievingUserData:
            return "Error Retrieving User Data"
        case .pendingSignatures:
            return "Pending Signatures"
        }
    }
}
