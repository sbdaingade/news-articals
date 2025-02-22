//
//  MainView.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 17/11/24.
//

import SwiftUI
import CoreData



enum TabViewState {
    case newArticle
    case search
    case bookmark
    
    func getTabbarButtonImage(tabIndex: Int) -> String {
        switch self {
        case .newArticle:
            return tabIndex == 0 ? "house" : "house.fill"
        case .search:
            return tabIndex == 1 ? "magnifyingglass" : "magnifyingglass.circle.fill"
        case .bookmark:
            return tabIndex == 2 ? "bookmark" : "bookmark.fill"
        }
    }
    
    func getTabTitle() -> String {
        switch self {
        case .newArticle:
            return "New Articles"
        case .search:
            return "Search"
        case .bookmark:
            return "Bookmarks"
        }
    }
    
    func getTabIndex() ->Int {
        switch self {
        case .newArticle:
            return 0
        case .search:
            return 1
        case .bookmark:
            return 2
        }
    }
}



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
                    tabView(tabType: .newArticle)
                }.tag(0)
            
            SearchView(tabselection: $tabSelection)
                .tabItem {
                    tabView(tabType: .search)
                }.tag(1)
            
            BookmarksView(tabselection: $tabSelection)
                .tabItem {
                    tabView(tabType: .bookmark)
                }.tag(2)
            
                .onChange(of: tabSelection, {
                    debugPrint("Index selected \(tabSelection)")
                })
                
        }
    }
    
    func tabView(tabType: TabViewState) -> some View {
        return CustomTabButtonView(text: tabType.getTabTitle(), iconName: tabType.getTabbarButtonImage(tabIndex: tabSelection), buttonState: tabSelection == tabType.getTabIndex() ? .normal : .selected, action: {
            debugPrint("Index selected ere \(tabType.getTabIndex())")
        })
    }
}

#Preview {
    MainView()
}
