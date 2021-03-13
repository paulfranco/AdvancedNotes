//
//  FolderTests.swift
//  AdvancedNotesTests
//
//  Created by Paul Franco on 3/11/21.
//

import XCTest
@testable import AdvancedNotes


class FolderTests: XCTestCase {

    var controller: PersistenceController!
    var context: NSManagedObjectContext {
        return controller.container.viewContext
    }
    
    override func setUp() {
        super.setUp()
        controller = PersistenceController.empty
        
    }

    override class func tearDown() {
        super.tearDown()
        //TODO: CLEAN UP
    }
    
    func testAddFolder() {
        let folder = Folder(name: "new", context: context)
        
        XCTAssertNotNil(folder.uuid)
        XCTAssertNotNil(folder.creationDate, "folder needs to have a creation date")
        XCTAssertTrue(folder.notes.count == 0, "created a folder with no notes in it")
        
        //let notes: [Note] = folder.notes.sorted()
        
    }
    
    func testAddNoteToFolder() {
        let noteTitle = "new"
        let folder = Folder(name: noteTitle, context: context)
        let note = Note(title: "add me", context: context)
        
        note.folder = folder
        
        XCTAssertTrue(note.folder?.name == noteTitle)
        XCTAssertNotNil(note.folder, "note should have been added to a folder")
        XCTAssertTrue(folder.notes.count == 1)
    }
    
    func testAddMultipleNotes() {
        let folder = Folder(name: "Folder", context: context)
        let note1 = Note(title: "First", context: context)
        let note2 = Note(title: "second", context: context)
        
        folder.add(note: note1)
        folder.add(note: note2)
        
        XCTAssertTrue(folder.notes.count == 2)
        
        XCTAssertTrue(folder.notes.sorted().first == note1)
        XCTAssertTrue(folder.notes.sorted().last == note2)
    }
    
    func testAddNoteAtIndex() {
        let folder = Folder(name: "Folder", context: context)
        let note1 = Note(title: "First", context: context)
        let note2 = Note(title: "second", context: context)
        let note3 = Note(title: "Third", context: context)
        
        
        folder.add(note: note1)
        folder.add(note: note2)
        folder.add(note: note2, at: 0)
        
        XCTAssertTrue(folder.notes.sorted().first == note3)
        XCTAssertTrue(folder.notes.sorted().last == note2)    }
}
