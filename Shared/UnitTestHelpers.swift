//
//  UniteTestHelpers.swift
//  AdvancedNotes
//
//  Created by Paul Franco on 3/9/21.
//

import Foundation
import CoreData

struct UnitTestHelpers {
    static func deletesAllNotes(container: NSPersistentCloudKitContainer) {
        let context = container.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        let deleteResquest = NSBatchDeleteRequest(fetchRequest: request)
        
        try? container.persistentStoreCoordinator.execute(deleteResquest, with: context)
    }
}
