//
//  reminderApp.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 18/11/2022.
//

import SwiftUI

@main
struct reminderApp: App {
    let persistenceController = PersistenceController.shared // is singleton class - one instance used across whole app

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
