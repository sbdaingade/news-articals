//
//  NewsArticalsApp.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 06/11/24.
//

import SwiftUI

@main
struct NewsArticalsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
