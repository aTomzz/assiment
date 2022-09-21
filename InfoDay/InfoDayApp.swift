//
//  InfoDayApp.swift
//  InfoDay
//
//  Created by e9207182 on 21/9/2022.
//

import SwiftUI

@main
struct InfoDayApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
