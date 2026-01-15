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
    @Published public private(set) var loadingState: LoadingState = LoadingState.idle
    @Published private(set) var arrOfSearchProducts = [Article]()
    @Published public private(set) var loadingModel: LoaderModel = LoaderModel()
    
    private var cancellable = Set<AnyCancellable>()
    
    public enum Input {
        case getAllProducts(Date)
        case search(String)
    }
    
    @Published public var input: Input?
    
    init() {
        $input.compactMap{$0}.sink {[unowned self] action in
            switch action {
            case .getAllProducts(let date):
                getData(date)
            case .search(let str):
                searchArticleData(str)
            }
        }.store(in: &cancellable)
    }
    
    private func getData(_ date: Date) {
        loadingState = .loading
        self.loadingModel.icon = "newspaper"
        self.loadingModel.title = "Loading..."
      
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        debugPrint(dateFormatter.string(from: date))

        Task {
            DSNewsArticlesCommunicator.getArticlesData(strDate: dateFormatter.string(from: date)).compactMap{$0}.sink { response in
                switch response {
                case .finished:
                    debugPrint("success")
                    self.loadingState = .idle
                  
                case .failure(let error):
                    debugPrint("\(error.localizedDescription)")
                    self.loadingState = .idle
                    self.loadingState = .failed(error.localizedDescription)

                }
            } receiveValue: {[weak self] articlesData in
                self?.loadingModel.title = "completed..."
                self?.arrOfProducts = []
                self?.arrOfProducts = articlesData.articles ?? []
                debugPrint("\(String(describing: self?.arrOfProducts.first?.title))")
            }.store(in: &cancellable)
        }
    }
    
    
    private func searchArticleData(_ searchQuery: String) {
        loadingState = .loading
        self.loadingModel.icon = "newspaper"
        self.loadingModel.title = "Searching..."
        if searchQuery.isEmpty {
            return
        }
        Task {
            DSNewsArticlesCommunicator.searchArticlesDataUsingPublisher(searchQuery: searchQuery).compactMap{$0}.sink { response in
                switch response {
                case .finished:
                    debugPrint("success")
                    self.loadingState = .idle
                case .failure(let error):
                    debugPrint("\(error.localizedDescription)")
                    self.loadingState = .idle
                    self.loadingState = .failed(error.localizedDescription)
                }
            } receiveValue: {[weak self] articlesData in
                self?.arrOfSearchProducts = []
                self?.arrOfSearchProducts = articlesData.articles ?? []
                debugPrint("\(String(describing: self?.arrOfSearchProducts.first?.title))")
            }.store(in: &cancellable)
        }
    }
    
    
    deinit {
        cancellable.forEach{$0.cancel()}
    }
}
