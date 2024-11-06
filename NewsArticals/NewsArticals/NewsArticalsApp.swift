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
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
