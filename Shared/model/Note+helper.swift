//
//  Note+helper.swift
//  AdvancedNotes
//
//  Created by Paul Franco on 3/9/21.
//

import Foundation
import CoreData

extension Note: Identifiable {
    
    convenience init(title: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.creationDate = Date()
        
        try? context.save()
    }
    
    static func fetch(_ predicate: NSPredicate) -> NSFetchRequest<Note> {
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        request.predicate = predicate
        return request
    }
    
}
