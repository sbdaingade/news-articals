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
    let items = ["Swift", "Kotlin", "Java", "Python", "C++"]
    
    var filteredItems: [String] {
        searchText.isEmpty ? items : items.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
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
            
            List(filteredItems, id: \.self) { item in
                Text(item)
            }
        }
        .navigationTitle("Languages")
    }
}

#Preview {
    SearchView(tabselection: .constant(1))
}
