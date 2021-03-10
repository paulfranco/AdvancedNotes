//
//  NoteTests.swift
//  AdvancedNotesTests
//
//  Created by Paul Franco on 3/9/21.
//

import XCTest
@testable import AdvancedNotes

class NoteTests: XCTestCase {

    var controller: PersistenceController!
    
    override func setUp() {
        super.setUp()
        controller = PersistenceController.empty
    }
    
    override func tearDown() {
        super.tearDown()
        UnittestHelpers.deletesAllNotes(container: controller.container)
    }
    
    func testAddNote() {
        let context = controller.container.viewContext
        let title = "new"
        let note = Note(title: title, context: context)
        
        XCTAssertTrue(note.title == title)
        XCTAssertNotNil(note.creationDate, "My note should have a date")
        
    }

    func testUpdateNote() {
        let context = controller.container.viewContext
        let note = Note(title: "My cool note", context: context)
        note.title = "New Title"
        
        XCTAssertTrue(note.title == "New Title")
        XCTAssertFalse(note.title == "My cool note", "note title not correctly updated")
        
    }
    
    func testFetchNotes() {
        let context = controller.container.viewContext
        
        let note = Note(title: "Fetch me", context: context)
        
        let request = Note.fetch(NSPredicate.all)
        
        let fetchedNotes = try? context.fetch(request)
        
        XCTAssertTrue(fetchedNotes!.count > 0, "Need to have at least one note")
        
        XCTAssertTrue(fetchedNotes?.first == note, "new note should be fetched")
    }
    
    func testSave() {
        // Asynchronous testing
        
        expectation(forNotification: .NSManagedObjectContextDidSave, object: controller.container.viewContext) { _ in
            return true
        }
        
        controller.container.viewContext.perform {
            let note = Note(title: "title", context: self.controller.container.viewContext)
            XCTAssertNotNil(note, "Note should be there")
        }
        
        waitForExpectations(timeout: 2.0) { (error) in
            XCTAssertNil(error, "Saving not complete")
        }
    }
    
    func testDeleteNote() {
        let context = controller.container.viewContext
        let note = Note(title: "Note to delete", context: context)
        
        Note.delete(note: note)
        
        let request = Note.fetch(NSPredicate.all)
        
        let fetchedNotes = try? context.fetch(request)
        
        XCTAssertTrue(fetchedNotes!.count == 0, "core data fetch should be empty")
        
        XCTAssertFalse(fetchedNotes!.contains(note), "fetched notes should not contain my deleted note")
        
    }
}
