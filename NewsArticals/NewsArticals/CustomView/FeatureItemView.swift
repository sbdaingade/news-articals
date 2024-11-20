//
//  FeatureItemView.swift
//  E-commerce
//
//  Created by Sachin Daingade on 12/04/23.
//

import SwiftUI

struct FeatureItemView: View {
    let player: Player
    var body: some View {
        AsyncImage(url: URL(string: player.image)) { phase in
            switch phase {
            case .success(let img):
                img
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                
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
    }
}

struct FeatureItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureItemView(player: Player(name: "", image: "https://www.vskills.in/certification/blog/wp-content/uploads/2015/01/structure-of-a-news-report.jpg"))
    }
}
