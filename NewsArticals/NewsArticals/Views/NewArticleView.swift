//
//  NewArticleView.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 20/11/24.
//

import SwiftUI

struct NewArticleView: View {
    @Binding var tabselection: Int
    @State private var date = Calendar.current.date(byAdding: .day, value: -3, to: Date())!

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        FeatureTabView()
                            .padding(.vertical, 0)
                            .frame(minHeight: 280)
                        SubTitleView(title: "News Articles")
                        
                    }
                }
                .toolbar {
                    HStack {
                        DatePicker(
                            "Start Date",
                            selection: $date,
                            displayedComponents: [.date]
                        )
                    }
                    
                    Button("Setting") {
                        print("Setting tapped!")
                    }
                    
                    Button("Help") {
                        print("Help tapped!")
                    }
                }
            }
            .navigationTitle("News")
        }
    }
}

#Preview {
    NewArticleView(tabselection: .constant(0))
}
