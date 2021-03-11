//
//  TextViewWrapper.swift
//  AdvancedNotes
//
//  Created by Paul Franco on 3/10/21.
//

import SwiftUI

struct TextViewWrapper: NSViewRepresentable {
    
    let note: Note
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, note: note)
    }
    
    func makeNSView(context: Context) -> NSTextView {
        let nsview = NSTextView()
        
        nsview.isRichText = true
        nsview.isEditable = true
        nsview.isSelectable = true
        nsview.allowsUndo = true
        
        nsview.usesInspectorBar = true
        
        nsview.usesFindPanel = true
        nsview.usesFindBar = true
        
        nsview.usesRuler = true
        
        nsview.isGrammarCheckingEnabled = true
        nsview.isContinuousSpellCheckingEnabled = true
        
        nsview.delegate = context.coordinator
        
        return nsview
    }
    
    func updateNSView(_ nsView: NSTextView, context: Context) {
        //nsView.textStorage?.setAttributtedString(note.formattedText)
        nsView.textStorage?.setAttributedString(note.formattedText)
        context.coordinator.note = note
    }
    
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: TextViewWrapper
        var note: Note
        
        init(_ parent: TextViewWrapper, note: Note) {
            self.parent = parent
            self.note = note
        }
        
        func textDidChange(_ notification: Notification) {
            if let textview = notification.object as? NSTextView {
                //parent.note.formattedText = textview.attributedString()
                note.formattedText = textview.attributedString()
            }
        }
    }
    
}

struct TextViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        TextViewWrapper(note: Note(context: PersistenceController.preview.container.viewContext))
    }
}
