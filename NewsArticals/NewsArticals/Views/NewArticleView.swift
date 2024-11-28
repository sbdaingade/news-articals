//
//  NewArticleView.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 20/11/24.
//

import SwiftUI

struct NewArticleView: View {
    @Binding var tabselection: Int
    @State private var date = Calendar.current.date(byAdding: .day, value: -3, to: Date())!
    @StateObject var viewModel = NewArticleViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        FeatureTabView()
                            .padding(.vertical, 0)
                            .frame(minHeight: 280)
                        SubTitleView(title: "News Articles")
                        
//                        List(viewModel.arrOfProducts) { product in
//                            ScrollView {
//                                let viewModel = ArticleCellViewModel(withArticle: product)
//                                NavigationLink {
//                                    // ProductDetailView(product: product)
//                                } label: {
//                                    ArticleCell(viewModel: viewModel)
//                                }
//                            }
//                        }
                        
                       
                    }
                }
                .toolbar {
                    HStack {
                        DatePicker(
                            "Start Date",
                            selection: $date,
                            displayedComponents: [.date]
                        )
                    }
                    
                    Button("Setting") {
                        print("Setting tapped!")
                    }
                    
                    Button("Help") {
                        print("Help tapped!")
                    }
                }
            }
            .onAppear(perform: {
                viewModel.input = .getAllProducts
            })
            .navigationTitle("News")
        }
    }
}

#Preview {
    NewArticleView(tabselection: .constant(0))
}
