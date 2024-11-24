//
//  SDSession.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 24/11/24.
//

import Alamofire
import Foundation

public struct LCProductionSession {
    public static var `default` = Session(interceptor: Interceptor())
}
