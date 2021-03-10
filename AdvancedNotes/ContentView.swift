//
//  ContentView.swift
//  AdvancedNotes
//
//  Created by Paul Franco on 3/9/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedNote: Note? = nil
    
    var body: some View {
        HSplitView {
            NoteListView(selectedNote: $selectedNote)
                .frame(minWidth: 100, idealWidth: 150, maxWidth: 300)
            
            
            if selectedNote != nil {
                NoteView(note: selectedNote!)
            } else {
                Text("please select a note")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
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
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
