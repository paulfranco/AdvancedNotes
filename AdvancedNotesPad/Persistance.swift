//
//  Persistance.swift
//  AdvancedNotesPad
//
//  Created by Paul Franco on 3/9/21.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "AdvancedNotes")
        if inMemory {
            container.persistentStoreDecriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in}
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })

    static var preview: PersistenceController = {
        let result = PersistanceController(inMemory: true)
        let viewContext = result.container.viewContext
      //  for _ in 0..<10 {
      //      let newItem = Item(context: viewContext)
      //      newItem.timestamp = Date()
      //  }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
