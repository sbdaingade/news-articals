//
//  SubTitleView.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 20/11/24.
//

import SwiftUI

struct SubTitleView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(.heavy)
            
            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
        .padding(.bottom, 10)
       
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        SubTitleView(title: "News")
    }
}
