//
//  ArticleDetailView.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 20/11/24.
//

import SwiftUI
import UIKit

struct CustomShape: Shape {

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
        return Path(path.cgPath)
    }
}

struct ArticleDetailView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading, spacing: 5) {
                    TitleView(title: "Sachin Daingade")
                    
                    NewImageView(image: "18-Sachin")
                    
                    // Spacer()
                    // MARK: - Description
                    VStack(alignment: .center, spacing: 0){
                        ScrollView(.vertical, showsIndicators: false) {
                            Text("""
                             A news report follows a particular pattern in reporting as well as editing. Every newspaper might have its own style of writing but a general format followed by all the newspapers at base levels is systematically divided into several parts. Roughly speaking a news story structure follows 1-2-3-4 steps, that is:

                             1. The lead. What is the most important news? How can you write it in the clearest way and make it interesting too?

                             2. Elaborate on the lead. Two, three, four or five paragraphs that explain support and amplify lead

                             3. Key background and context of event, if needed; information that helps readers understands more about the news they are reading.

                             4. More elaboration of the news, in descending order of importance.

                             The main impetus lies in the body of the report. Once the introduction has been written, there are rules that must be applied to any following paragraphs. Each following paragraph should be about 30 words long which will help to present information in shorter doses and maintain interest longer. Each paragraph should aim to be as independent of the other paragraphs as far as possible (inverted pyramid structure). The journalist must present information in descending order of importance. To get a deeper understanding, a news story or report is divided into 5 parts namely;
""")
                            .multilineTextAlignment(.leading)
                            .font(.system(.body, design: .rounded))
                            
                        }// :SCROLLVIEW
                        Spacer()
                        Button("Add Bookmark") {
                            
                        }.frame( height: 50, alignment: .leading)
                        
                    }
                    .padding(.horizontal)
                    .background(
                        Color.white.opacity(1)
                            .clipShape(CustomShape())
                            .padding(.top, -10)
                            .zIndex(0)
                    )
                    .ignoresSafeArea(.all,edges: .all)
                }
            }
            .background(
                Color(red: 210/255, green:  221/255, blue: 123/255).opacity(0.70)
                    .ignoresSafeArea(.all,edges: .all) )
        } // Navigation
        .navigationTitle("Sachin")
    }
}

#Preview {
    ArticleDetailView()
}
