//
//  InfoDayApp.swift
//  InfoDay
//
//  Created by e9207182 on 21/9/2022.
//

import SwiftUI
import CoreData

@main
struct InfoDayApp: App {
    let persistenceController = PersistenceController.shared
    
    @AppStorage("shouldSeedData") var shouldSeedData: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(perform: seedData)
            
        }
    }
}

extension InfoDayApp {
    
    private func seedData() {
        
        if !shouldSeedData { return }
        
        let events: [[String : Any]] = [
            [ "id": "1", "title": "Guided Tour", "dept_id": "coms", "saved": true ],
            [ "id": "2", "title": "Career Talks", "dept_id": "coms", "saved": false ],
            [ "id": "3", "title": "MindDrive Demo", "dept_id": "comp", "saved": false ],
            [ "id": "4", "title": "Project Demo", "dept_id": "comp", "saved": false ],
        ]
        
        let viewContext = persistenceController.container.viewContext
        viewContext.automaticallyMergesChangesFromParent = true
        
        viewContext.performAndWait {
            let insertRequest = NSBatchInsertRequest(entity: Event.entity(), objects: events)
            
            let result = try? viewContext.execute(insertRequest) as? NSBatchInsertResult
            
            if let status = result?.result as? Int, status == 1 {
                print("Data Seeded")
                shouldSeedData = false
            }
        }
    }
}
