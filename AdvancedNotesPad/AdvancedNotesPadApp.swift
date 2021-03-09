//
//  AdvancedNotesPadApp.swift
//  AdvancedNotesPad
//
//  Created by Paul Franco on 3/9/21.
//

import SwiftUI

@main
struct AdvancedNotesPadApp: App {
    
    let persistenceController = persistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
