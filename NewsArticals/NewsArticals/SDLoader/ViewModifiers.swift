//
//  ViewModifiers.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 25/03/25.
//

import Combine
import SwiftUI

public enum LoadingState: Equatable {
    case idle
    case loading
    case failed(String)
}

public struct IdentifiableObject<T: Hashable>: Identifiable {
    public var id: Int {
        return value.hashValue
    }
    
    public let value: T
    
    public init(_ value: T) {
        self.value = value
    }
}

struct SDLoaderStateModifier: ViewModifier {
    let loadingState: Published<LoadingState>.Publisher
    @State private var showActivityIndicator: Bool = false
    @State private var errorMessage: IdentifiableObject<String>?
    @State var message:String?
    func body(content: Content) -> some View {
        ZStack {
            content
            if showActivityIndicator {
                SDHUDLoader(message: $message)
            }
        }
        .allowsHitTesting(!showActivityIndicator)
        .alert(item: $errorMessage, content:{ error in
            Alert(title: Text("Error"), message: Text("\(error.value)"), dismissButton: nil)
        } )
        .onReceive(loadingState, perform: { loadingState in
            switch loadingState {
            case .idle:
                message = "Almost there"
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    showActivityIndicator = false
                    message = "Loading..."
                }
            case .loading:
                message = "Loading..."
                showActivityIndicator = true
            case .failed(let errorString):
                showActivityIndicator = false
                errorMessage = IdentifiableObject(errorString)
            }
        })
    }
}

extension View {
 
    func sdHUD(_ loadingState: Published<LoadingState>.Publisher, message: String? = nil) -> some View {
        modifier(SDLoaderStateModifier(loadingState: loadingState, message: message))
    }
}
