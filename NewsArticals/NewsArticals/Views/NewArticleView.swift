//
//  NewArticleView.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 20/11/24.
//

import SwiftUI

struct NewArticleView: View {
    @Binding var tabselection: Int
    @State private var date = Calendar.current.date(byAdding: .day, value: -15, to: Date())!
    @StateObject var viewModel = NewArticleViewModel()
    @State var isPresented: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                MeshGradient(
                    width: 3,
                    height: 3,
                    points: [
                        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                        [0.0, 0.5], [0.3, 1.0], [1.0, 1.0],
                        [0.0, 1.0], [0.2, 1.0], [1.0, 1.0]
                    ],
                    colors: [
                        .teal,.cyan,.teal,
                        .white, .white, .white,
                        .white, .teal, .white
                    ]
                )
                .ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        FeatureTabView()
                        //  .padding(.vertical, 0)
                            .frame(minHeight: 300)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        SubTitleView(title: "News Articles")
                        
                        ScrollView {
                            LazyVStack(spacing: 5) {
                                ForEach(0..<viewModel.arrOfProducts.count, id: \.self) { index in
                                    let product = viewModel.arrOfProducts[index]
                                    NavigationLink {
                                        ArticleNewDetail(articleDetail: product)
                                    } label: {
                                        let viewModel = ArticleCellViewModel(withArticle: product)
                                        ArticleCell(viewModel: viewModel)
                                           
                                    }
                                }
                            }
                            .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
                        } //scrollview
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
                        isPresented.toggle()
                    }
                }
                
             
                
                if isPresented {
                    CustomAlert(presentAlert: $isPresented, alertType: .error(title: "Error", message: "Please confirm that you're still open to session requests then you will find the call from new user."), isShowVerticalButtons: false){
                        withAnimation{
                            isPresented.toggle()
                        }
                    } rightButtonAction: {
                        withAnimation{
                            isPresented.toggle()
                        }
                    }
                }
                    
                
            }
           
            .onAppear(perform: {
                
               if viewModel.arrOfProducts.count == 0 {
                   viewModel.input = .getAllProducts(date)
                }
            })
            .navigationTitle("News")
            .sdHUD(viewModel.$loadingState, message: "Loading...")

        }
//        .toolbarColorScheme(.dark, for: .navigationBar)
//
//        .toolbarBackground(Color.cyan, for: .navigationBar)
        .toolbarBackground(
                       Color.pink,
                       for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)

    }
}

#Preview {
    NewArticleView(tabselection: .constant(0))
}
