//
//  NoteView.swift
//  AdvancedNotes
//
//  Created by Paul Franco on 3/9/21.
//

import SwiftUI

struct NoteView: View {
    
    @ObservedObject var note: Note
    @State private var isDropTargeted: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Picker(selection: $note.status, label: Text("Status"), content: {
                ForEach(Status.allCases, id: \.self) { status in
                    Text(status.rawValue)
                }
            }).pickerStyle(SegmentedPickerStyle())
            .frame(maxWidth: 250)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            TextField("notes title", text: $note.title)
                //.font(.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            //TextEditor(text: $note.bodyText)
            TextViewWrapper(note: note)
            
            if note.img != nil {
                Image(nsImage: NSImage(data: note.img!) ?? NSImage())
                    .resizable()
                    .scaledToFit()
                    .contextMenu(ContextMenu(menuItems: {
                        Button(action: {
                            note.img = nil
                        }, label: {
                            Text("Remove Image")
                        })
                    }))
            }
            
            Text("Keywords:")
            
            Text("Linked Notes: ")
        }.padding()
        .background(isDropTargeted ? Color.gray : Color.clear)
        .onDrop(of: ["public.file-url"], isTargeted: $isDropTargeted, perform: { providers in
            handleDrop(providers: providers)
        })
        
    }
    
    func handleDrop(providers: [NSItemProvider]) -> Bool {
        let found = providers.loadObjects(ofType: URL.self) { item in
            if let image = NSImage(contentsOf: item.absoluteURL) {
                let data = image.tiffRepresentation
                note.img = data
                
            }
        }
        return found
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: Note(context: PersistenceController.preview.container.viewContext))
            .frame(width: 400, height: 400)
            .previewLayout(.fixed(width: 400.0, height: 400.0))
    }
}
