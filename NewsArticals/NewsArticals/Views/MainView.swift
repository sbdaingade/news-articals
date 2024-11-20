//
//  MainView.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 17/11/24.
//

import SwiftUI
import CoreData

struct MainView: View {
    @State var tabSelection: Int = 0
    @Environment(\.managedObjectContext) private var viewContext
    init() {
        UITabBar.appearance().backgroundColor = UIColor.init(white: 0.8, alpha: 0.7)
    }
    var body: some View {
        TabView(selection: $tabSelection) {
            NewArticleView(tabselection: $tabSelection)
                .tabItem {
                    Image(systemName: "book.pages")
                    Text("New Articles")
                }.tag(0)
            
            SearchView(tabselection: $tabSelection)
                .tabItem {
                    Image(systemName:"magnifyingglass")
                    Text("Search")
                }.tag(0)
            
            BookmarksView(tabselection: $tabSelection)
                .tabItem {
                    Image(systemName:"bookmark")
                    Text("Bookmarks")
                }.tag(0)
        }
    }
}

#Preview {
    MainView()
}
