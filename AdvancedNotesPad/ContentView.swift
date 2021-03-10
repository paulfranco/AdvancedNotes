//
//  ContentView.swift
//  AdvancedNotesPad
//
//  Created by Paul Franco on 3/9/21.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(fetchRequest: Note.fetch(NSPredicate.all)) private var notes: FetchedResults<Note>
    
    
    var body: some View {
        List {
            ForEach(notes) { note in
                Text("title \(note.title ?? "") date \(note.creationDate ?? Date(), formatter: itemFormatter)")
            }
            //.onDelete(perform: deleteItems)
        }
        .toolbar {
           // #if os(iOS)
           // EditButton()
           // #endif
            Button(action: {
                _ = Note(title: "Added on phone", context: viewContext)
            }) {
                Label("Add Note", systemImage: "plus")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext,
                                  PersistenceController.preview.container.viewContext)
    }
}
