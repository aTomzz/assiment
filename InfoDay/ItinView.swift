//
//  ItinView.swift
//  InfoDay
//
//  Created by e9207182 on 21/9/2022.
//
//
import SwiftUI
import CoreData

struct ItinView: View {

    @FetchRequest var events: FetchedResults<Event>
    @Environment(\.managedObjectContext) private var viewContext
    init() {
        
    
        self._events = FetchRequest(
            entity: Event.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "saved == true")
        )
    }
    
    


    var body: some View {
        List(events) { event in
            Text(event.title ?? "")
                .contextMenu {
                    Button("Remove from itinerary") {
                        viewContext.performAndWait {
                            event.saved = false
                            try? viewContext.save()
                        }
                    }
                }
            }
        }
}
    

struct ItinView_Previews: PreviewProvider {
    static var previews: some View {
        ItinView()
    }
}
