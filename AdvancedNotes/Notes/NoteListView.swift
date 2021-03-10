//
//  NoteListView.swift
//  AdvancedNotes
//
//  Created by Paul Franco on 3/9/21.
//

import SwiftUI

struct NoteListView: View {
    
    @Binding var selectedNote: Note?
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(fetchRequest: Note.fetch(NSPredicate.all)) private var notes: FetchedResults<Note>
    
    var body: some View {
        VStack {
            Text("Notes")
            Button(action:{
                _ = Note(title: "new note", context: context)
            }, label: {
                Text("Add")
            })
        
            List(notes) { note in
                Text("title \(note.title) with date \(note.creationDate , formatter: itemFormatter) ")
                    .font(.title)
                    .background(RoundedRectangle(cornerRadius: 5).fill(selectedNote == note ? Color.blue : Color(.lightGray)))
                    .onTapGesture {
                        selectedNote = note
                    }
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

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = PersistenceController.preview.container.viewContext
        let request = Note.fetch(NSPredicate.all)
        let fetchedNotes = try? context.fetch(request)
        
        
        return NoteListView(selectedNote: .constant(fetchedNotes?.first)).environment(\.managedObjectContext, context)
        
    }
}
