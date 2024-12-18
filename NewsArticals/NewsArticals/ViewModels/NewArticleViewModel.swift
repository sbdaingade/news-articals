//
//  NewArticleViewModel.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 24/11/24.
//

import Foundation
import Combine

@MainActor
class  NewArticleViewModel: ObservableObject {
    @Published private(set) var arrOfProducts = [Article]()
    private var cancellable = Set<AnyCancellable>()
    
    public enum Input {
        case getAllProducts
    }
    
    @Published public var input: Input?
    
    init() {
        $input.compactMap{$0}.sink {[unowned self] action in
            switch action {
            case .getAllProducts:
                getData()
            }
        }.store(in: &cancellable)
    }
    
    private func getData() {
        Task {
//            DSNewsArticlesCommunicator.getArticlesDataUsingPublisher().compactMap{$0}.sink { response in
//                switch response {
//                case .finished:
//                    debugPrint("success")
//                case .failure(let error):
//                    debugPrint("\(error.localizedDescription)")
//                }
//            } receiveValue: {[weak self] articles in
//                self?.arrOfProducts = articles.articles ?? []
//            }.store(in: &cancellable)
        }
    }

    deinit {
        cancellable.forEach{$0.cancel()}
    }
}
