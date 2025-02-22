//
//  FeatureTabView.swift
//  E-commerce
//
//  Created by Sachin Daingade on 12/04/23.
//

import SwiftUI

struct FeatureTabView: View {
    @StateObject var viewModel = FeatureViewModel()
    @State private var currentPage = 0
    var body: some View {
        
        TabView(selection: $currentPage) {
            ForEach(viewModel.arrOfWorldStreetJournalProducts) { post in
                FeatureItemView(article: post)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle()) // Page indicator dots
        
        .onAppear {
            if viewModel.arrOfWorldStreetJournalProducts.count == 0 {
                viewModel.input = .getWorldStreetJournalProducts
            }
        }
    }
}

struct FeatureTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureTabView()
    }
}
