//
//  NoteRow.swift
//  AdvancedNotes
//
//  Created by Paul Franco on 3/10/21.
//

import SwiftUI

struct NoteRow: View {
    
    let title: String
    let bodyText: String
    let creationDate: Date
    let isSelected: Bool
    
    let selectedColor: Color = Color("selectedColor")
    let unselectedColor: Color = Color("unselectedColor")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(title).bold()
                Spacer()
                Text(creationDate, formatter: itemFormatter).font(.footnote)
            }
            Text(bodyText)
                .lineLimit(4)
                .font(.caption)
        }
        .padding(5)
        .background(RoundedRectangle(cornerRadius: 5).fill(isSelected ? selectedColor : unselectedColor))
            
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        
        let bodyText = Note.defaultText
        
        return VStack(spacing: 5) {
            NoteRow(title: "Note Title", bodyText: bodyText, creationDate: Date(), isSelected: false)
            NoteRow(title: "Note Title", bodyText: bodyText, creationDate: Date(), isSelected: true)
        }.padding().frame(width: 400)
    }
}
