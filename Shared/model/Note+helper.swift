//
//  Note+helper.swift
//  AdvancedNotes
//
//  Created by Paul Franco on 3/9/21.
//

import Foundation
import CoreData

extension Note {
    
    convenience init(title: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.creationDate = Date()
        
        try? context.save()
    }
    
    override public func awakeFromInsert() {
        setPrimitiveValue(Date(), forKey: NoteProperties.creationDate)
        setPrimitiveValue(UUID(), forKey: NoteProperties.uuid )
    }
    
    var title: String {
        get { return title_ ?? "" }
        set { title_ = newValue }
    }
    
    var creationDate: Date {
        get { return creationDate_ ?? Date() }
        set { creationDate_ = newValue }
    }
    
    var bodyText: String {
        get { return bodyText_ ?? "" }
        set { bodyText_ = newValue }
    }
    
    var uuid: UUID {
        get { uuid_ ?? UUID() }
        set { uuid_ = newValue }
    }
    
    static func fetch(_ predicate: NSPredicate) -> NSFetchRequest<Note> {
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.sortDescriptors = [NSSortDescriptor(key: NoteProperties.creationDate, ascending: false)]
        request.predicate = predicate
        return request
    }
    
    static func delete(note: Note) {
        if let context = note.managedObjectContext {
            context.delete(note)
        }
    }
    
}

//MARK: - property names as strings

struct NoteProperties {
    static let creationDate = "creationDate_"
    static let title = "title_"
    static let bodyText = "bodyText_"
    static let uuid = "uuid_"
}
