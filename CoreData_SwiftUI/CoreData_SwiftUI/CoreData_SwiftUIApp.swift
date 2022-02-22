//
//  CoreData_SwiftUIApp.swift
//  CoreData_SwiftUI
//
//  Created by Nicholas Sseguya on 22/02/2022.
//

import SwiftUI

@main
struct CoreData_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
