//
//  ArticleCellViewModel.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 24/11/24.
//

import Foundation
import Combine

public class ArticleCellViewModel: ObservableObject, Identifiable {
    private var cancallables = Set<AnyCancellable>()
    @Published public var title: String
    @Published public var urlString: String
    @Published public var description: String
    private var article: Article
    
    init(withArticle article: Article) {
        self.article = article
        self.title = article.title ?? ""
        self.urlString = article.urlToImage ?? "https://elementor.com/cdn-cgi/image/f=auto,w=1920,h=1080/https://elementor.com/blog/wp-content/uploads/2023/09/Frame-55.png"
        self.description = article.description ?? ""
    }
    
    deinit {
        cancallables.forEach{$0.cancel()}
    }
}
