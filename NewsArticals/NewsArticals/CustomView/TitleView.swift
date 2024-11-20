//
//  TitleView.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 20/11/24.
//

import SwiftUI

struct TitleView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .fontWeight(.light)
            
            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
        .padding(.bottom, 10)
       
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Main News")
    }
}
