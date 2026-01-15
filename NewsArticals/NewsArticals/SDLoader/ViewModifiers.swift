//
//  ViewModifiers.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 25/03/25.
//

import Combine
import SwiftUI

struct LoaderModel {
    var title: String?
    var subTitle: String?
    var icon: String?
    var titleFont: Font?
    var subTitleFont: Font?
    var backgroundColor: Color?
}

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
    let loaderModelState: Published<LoaderModel>.Publisher
    
    
    @State private var showActivityIndicator: Bool = false
    @State private var errorMessage: IdentifiableObject<String>?
    @State var loaderModel :LoaderModel? = LoaderModel()
    func body(content: Content) -> some View {
        ZStack {
            content
//            if showActivityIndicator {
//                SDHUDLoader(message: $message)
//            }
            
                .fullScreenCover(isPresented: $showActivityIndicator) {
                    ZStack {
                        //SDHUDLoader(message: $message)
                        SDHUDLoader(loaderModel: $loaderModel)
                    }
                   // .background(Color.black.opacity(0.5))
                }
                .transaction( { transaction in
                    transaction.disablesAnimations = true
                })
                .background(Color.clear)
        }
        .interactiveDismissDisabled(true)
        .allowsHitTesting(!showActivityIndicator)
        .alert(item: $errorMessage, content:{ error in
            Alert(title: Text("Error"), message: Text("\(error.value)"), dismissButton: nil)
        } )
        .onReceive(loaderModelState) { model in
            loaderModel = model
        }
        
        .onReceive(loadingState, perform: { loadingState in
            switch loadingState {
            case .idle:
                showActivityIndicator = false
            case .loading:
                showActivityIndicator = true
            case .failed(let errorString):
                showActivityIndicator = false
                errorMessage = IdentifiableObject(errorString)
            }
        })
    }
}

extension View {
 
    func sdHUD(_ loadingState: Published<LoadingState>.Publisher, loaderModel: Published<LoaderModel>.Publisher) -> some View {
        modifier(SDLoaderStateModifier(loadingState: loadingState, loaderModelState: loaderModel))
    }
}
