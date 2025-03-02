//
//  ArticleNewDetail.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 01/03/25.
//

import SwiftUI
import Translation

struct ArticleNewDetail: View {
    var articleDetail: Article
    @State private var showTransalation: Bool = false
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            // PHOTO
            ZStack {
                AsyncImage(url: URL(string: articleDetail.urlToImage ?? "")) { img in
                    img
                        .resizable()
                        .scaledToFit()
                        .padding()
                } placeholder: {
                    Image("18-Sachin")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }

            } // :ZSTACK
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
            
            // Name
            Text(articleDetail.title?.uppercased() ?? "")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("@Author: \(articleDetail.author ?? "")")
                .fontWeight(.semibold)
                .foregroundColor(.gray)

            
            ScrollView {
              
                
                Text(articleDetail.description ?? "")
                    .font(.subheadline)
            }
            .translationPresentation(isPresented: $showTransalation, text: articleDetail.description ?? "")
        } //: VSTACK
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .navigationTitle("Details")
        .toolbar {
             ToolbarItem(placement: .navigationBarTrailing) {
                 Menu(content: {
                     Button("Translate article") {
                         showTransalation = true
                     }
                     Button("Cancel") {
                     }
                 }, label: {
                     Image(systemName: "translate")
                 })
              }
          }
    }
}
