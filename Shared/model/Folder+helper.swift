//
//  Folder+helper.swift
//  AdvancedNotes
//
//  Created by Paul Franco on 3/11/21.
//

import Foundation
import CoreData

extension Folder {
    
    //TODO: init
    convenience init(name: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
    }
    
    override public func awakeFromInsert() {
        setPrimitiveValue(Date(), forKey: NoteProperties.creationDate)
        setPrimitiveValue(UUID(), forKey: NoteProperties.uuid)
    }
    
    var uuid: UUID {
        get { uuid_ ?? UUID() }
        set { uuid_ = newValue }
    }
    
    var creationDate: Date {
        get { return creationDate_ ?? Date() }
        set { creationDate_ = newValue }
    }
    
    var name: String {
        get { return name_ ?? "" }
        set { name_ = newValue }
    }
    
    //TODO: optional notes
    var notes: Set<Note> {
        get { notes_ as? Set<Note> ?? [] }
        //set { notes_ = newValue as NSSet }
    }
    
    
    func add(note: Note, at index: Int? = nil) {
        let oldNotes = self.notes.sorted()
        
        if let index = index {
            note.order = Int32(index)
            
            let changeNotes = oldNotes.filter { $0.order >= index }
            for note in changeNotes { note.order += 1 }
        } else {
            note.order = (oldNotes.last?.order ?? 0) + 1
        }
        note.folder = self
        //self.notes_?.adding(note)
    }
    //TODO: fetch request
    
    
    //TODO: delete
    
    
}

//TODO: define string properties
