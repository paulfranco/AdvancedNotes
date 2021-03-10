//
//  NoteView.swift
//  AdvancedNotes
//
//  Created by Paul Franco on 3/9/21.
//

import SwiftUI

struct NoteView: View {
    
    @ObservedObject var note: Note
    
    var body: some View {
        VStack {
            TextField("notes title", text: $note.title)
            
            TextEditor(text: $note.bodyText)
        }
        
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: Note(context: PersistenceController.preview.container.viewContext))
            .frame(width: 400, height: 400)
            .previewLayout(.fixed(width: 400.0, height: 400.0))
    }
}
