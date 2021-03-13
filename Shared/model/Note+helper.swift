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
    
    var formattedText: NSAttributedString {
        get {
            if let data = formattedText_ as NSData? {
                return data.toAttributedString()
            } else {
                return NSAttributedString(string: "")
            }
        }
        set {
            bodyText_ = newValue.string
            formattedText_ = newValue.toNSData() as Data?
        }
    }
    
    var uuid: UUID {
        get { uuid_ ?? UUID() }
        set { uuid_ = newValue }
    }
    
    var status: Status {
        get { return Status(rawValue: status_ ?? "") ?? Status.draft }
        set { status_ = newValue.rawValue }
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
    
    //MARK: - preview helper properties
    static let defaultText = "dksjdkjskdjskjdklsjd jdks dlkjdkl jdkl skjdcvcvc cx  cxcxcx cx cxc c cx c cx cx cxcxcxc cxcxc cx cxcxcxc skldkl djkldj ljdlksd jds dkjds jds dskldjskl"
}

//MARK: - sort notes for showing in list
extension Note: Comparable {
    public static func < (lhs: Note, rhs: Note) -> Bool {
        lhs.order < rhs.order
    }
    
    
}

//MARK: - property names as strings

struct NoteProperties {
    static let creationDate = "creationDate_"
    static let title = "title_"
    static let bodyText = "bodyText_"
    static let formattedText = "formattedText_"
    static let uuid = "uuid_"
}
