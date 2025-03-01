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
        case getAllProducts(Date)
    }
    
    @Published public var input: Input?
    
    init() {
        $input.compactMap{$0}.sink {[unowned self] action in
            switch action {
            case .getAllProducts(let date):
                getData(date)
            }
        }.store(in: &cancellable)
    }
    
    private func getData(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        debugPrint(dateFormatter.string(from: date))

        Task {
            DSNewsArticlesCommunicator.getArticlesData(strDate: dateFormatter.string(from: date)).compactMap{$0}.sink { response in
                switch response {
                case .finished:
                    debugPrint("success")
                case .failure(let error):
                    debugPrint("\(error.localizedDescription)")
                }
            } receiveValue: {[weak self] articlesData in
                self?.arrOfProducts = []
                self?.arrOfProducts = articlesData.articles ?? []
                debugPrint("\(String(describing: self?.arrOfProducts.first?.title))")
                
            }.store(in: &cancellable)
        }
    }
    
    deinit {
        cancellable.forEach{$0.cancel()}
    }
}
