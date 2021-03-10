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
            HStack {
                Text("Notes")
                Spacer()
                Button(action:{
                    _ = Note(title: "new note", context: context)
                }, label: {
                    Image(systemName: "plus")
                    //Text("Add")
                })
                
            }.padding([.top, .horizontal])
            List {
                ForEach(notes) { note in
                    NoteRow(title: note.title, bodyText: note.bodyText, creationDate: note.creationDate, isSelected: note == selectedNote)
                        .onTapGesture {
                            selectedNote = note
                        }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 1, trailing: 0))
            }
        }
    }
}


struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = PersistenceController.preview.container.viewContext
        let request = Note.fetch(NSPredicate.all)
        let fetchedNotes = try? context.fetch(request)
        
        
        return NoteListView(selectedNote: .constant(fetchedNotes?.first)).environment(\.managedObjectContext, context)
        
    }
}


