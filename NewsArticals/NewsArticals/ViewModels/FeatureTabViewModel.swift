//
//  FeatureTabViewModel.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 22/02/25.
//
import Combine
import Foundation

class FeatureViewModel: ObservableObject {
    @Published var arrOfWorldStreetJournalProducts: [Article] = []
    private var cancellable = Set<AnyCancellable>()
    @Published public private(set) var loadingState: LoadingState = LoadingState.idle

    public enum Input {
        case getWorldStreetJournalProducts
    }
    
    @Published public var input: Input?
    
    init() {
        $input.compactMap{$0}.sink {[unowned self] action in
            switch action {
            case .getWorldStreetJournalProducts:
                getDataWorldSJ()
            }
        }.store(in: &cancellable)
    }
    
    
    private func getDataWorldSJ() {
        loadingState = .loading
        Task {
            DSNewsArticlesCommunicator.getWorldStreetJournalArticlesData().compactMap{$0}.sink { response in
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
                self?.arrOfWorldStreetJournalProducts = []
                self?.arrOfWorldStreetJournalProducts = articlesData.articles ?? []
                debugPrint("\(String(describing: self?.arrOfWorldStreetJournalProducts.first?.title))")
            }.store(in: &cancellable)
        }
    }
    
    deinit {
        cancellable.forEach{$0.cancel()}
    }
}
