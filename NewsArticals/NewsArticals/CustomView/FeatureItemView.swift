//
//  FeatureItemView.swift
//  E-commerce
//
//  Created by Sachin Daingade on 12/04/23.
//

import SwiftUI
@MainActor
struct FeatureItemView: View {
    let article: Article
    var body: some View {
        VStack(spacing: 2) {
            AsyncImage(url: URL(string: article.urlToImage ?? "https://www.vskills.in/certification/blog/wp-content/uploads/2015/01/structure-of-a-news-report.jpg")) { phase in
                switch phase {
                case .success(let img):
                    img
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .frame(minHeight: 240)
                case .failure(_), .empty:
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .foregroundColor(.purple)
                    
                @unknown default:
                    ProgressView()
                        .foregroundColor(.purple)
                }
            }
            VStack(alignment: .leading, spacing: 0) {
                Text(article.title ?? "")
                    .foregroundColor(.blue)
                    .font(.custom("Poppins-Light", size: 14))
                    .bold()
                    .lineLimit(1)
                if let desc = article.description {
                    Text(desc)
                        .font(.custom("Poppins-Light", size: 12))
                        .lineLimit(3)
                        .foregroundColor(.black)
                    
                }
            }
        }
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }
}

//struct FeatureItemView_Previews: PreviewProvider {
//    static var previews: some View {
////        FeatureItemView(player: Player(name: "", image: "https://www.vskills.in/certification/blog/wp-content/uploads/2015/01/structure-of-a-news-report.jpg"))
//    }
//}
