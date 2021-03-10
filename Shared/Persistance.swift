//
//  Persistance.swift
//  AdvancedNotesPad
//
//  Created by Paul Franco on 3/9/21.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "AdvancedNotes")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
                
            }
    })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        
        //UnitTestHelpers.deletesAllNotes(container: result.container)
        
        for _ in 0..<5 {
            let newItem = Note(title: "a new note", context: viewContext)
            newItem.bodyText = Note.defaultText
            
        }
        /*
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
         */
        return result
    }()
    
    //MARK: - unit tests
    static var empty: PersistenceController = {
        return PersistenceController(inMemory: true)
    }()
    
}
