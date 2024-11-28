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
    @State var isPresented: Bool = false

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
                }//scrollview
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
                viewModel.input = .getAllProducts
            })
            .navigationTitle("News")
        }
    }
}

#Preview {
    NewArticleView(tabselection: .constant(0))
}
