//
//  NewImageView.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 20/11/24.
//

import SwiftUI

struct NewImageView: View {
    var image: String
    
    @State private var isAnimated: Bool = false
    var body: some View {
        HStack(alignment:.center, spacing: 1) {
         // Photo
            Image(image)
                .resizable()
                .scaledToFit()
                .offset(y: isAnimated ? 0 : -35)
                .cornerRadius(20)
        } //:HStack
        .onAppear {
            withAnimation(.easeOut(duration: 0.56)) {
                isAnimated.toggle()
            }
        }
    }
}

#Preview {
    NewImageView(image: "18-Sachin")
}
