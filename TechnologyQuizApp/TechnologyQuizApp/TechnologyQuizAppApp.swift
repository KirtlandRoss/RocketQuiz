//
//  TechnologyQuizAppApp.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/8/21.
//

import SwiftUI

@main
struct TechnologyQuizAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
