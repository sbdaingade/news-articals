//
//  SearchView.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 20/11/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var tabselection: Int
    @State private var searchText = ""
    @StateObject var viewModel = NewArticleViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        TextField("Search news articles", text: $searchText)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        
                        if !searchText.isEmpty {
                            Button(action: { searchText = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        LazyVStack(spacing: 5) {
                            ForEach(0..<viewModel.arrOfSearchProducts.count, id: \.self) { index in
                                let product = viewModel.arrOfSearchProducts[index]
                                NavigationLink {
                                    ArticleNewDetail(articleDetail: product)
                                } label: {
                                    let viewModel = ArticleCellViewModel(withArticle: product)
                                    ArticleCell(viewModel: viewModel)
                                }
                            }
                        }
                        .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                }
                .onChange(of: searchText) { newValue in
                    if newValue.count >= 3 {
                        viewModel.input = .search(searchText)
                    }
                }
                .navigationTitle("Search")
                .sdHUD(viewModel.$loadingState, loaderModel: viewModel.$loadingModel)
            }
        }
    }
}

#Preview {
    SearchView(tabselection: .constant(1))
}
