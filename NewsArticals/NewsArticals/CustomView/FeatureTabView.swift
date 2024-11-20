//
//  FeatureTabView.swift
//  E-commerce
//
//  Created by Sachin Daingade on 12/04/23.
//

import SwiftUI

struct Player: Identifiable{
    let id: UUID = UUID()
    let name: String
    let image: String
}



struct FeatureTabView: View {
    let players: [Player] = [Player(name: "", image: "https://www.vskills.in/certification/blog/wp-content/uploads/2015/01/structure-of-a-news-report.jpg"),Player(name: "", image: "https://www.vskills.in/certification/blog/wp-content/uploads/2015/01/structure-of-a-news-report.jpg"),Player(name: "", image: "https://www.vskills.in/certification/blog/wp-content/uploads/2015/01/structure-of-a-news-report.jpg")]
    
    var body: some View {
        TabView {
            ForEach(players) { player in
                FeatureItemView(player: player)
                    .padding(.top, 10)
                    .padding(.horizontal,15)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
  }
}

struct FeatureTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureTabView()
    }
}

