//
//  NoteListView.swift
//  AdvancedNotes
//
//  Created by Paul Franco on 3/9/21.
//

import SwiftUI

struct NoteListView: View {
    
    @Binding var selectedNote: Note?
    //@State private var showDeleteAlert: Bool = false
    @State private var shouldDeleteNote: Note? = nil
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
                        .contextMenu(ContextMenu(menuItems: {
                            Button(action: {
                                self.shouldDeleteNote = note
                            }, label: {
                                Text("Delete")
                            })
                        }))
                        
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 1, trailing: 0))
            }
            /*
            .alert(isPresented: $showDeleteAlert, content: {
                deleteAlert()
            })
            */
            .alert(item: $shouldDeleteNote, content: { noteToDelete in
                deleteAlert(note: noteToDelete)
            })
        }
    }
    func deleteAlert(note: Note) -> Alert {
        Alert(title: Text("Are you sure you want to delete this Note?"), message: nil, primaryButton: Alert.Button.cancel(), secondaryButton: Alert.Button.destructive(Text("Delete"), action: {
            if selectedNote == note {
                selectedNote = nil
            }
            Note.delete(note: note)
        }))
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


