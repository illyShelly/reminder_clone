//
//  Persistence.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 18/11/2022.
//

import CoreData
import UIKit

struct PersistenceController {
    static let shared = PersistenceController() // the singleton
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
//        // As default hard-coded 4 lines of lists in the preview
        for idx in 1 ..< 4 {
            let newList = Listing(context: viewContext)
                newList.name = "Hello \(idx)"
           }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
            
        return result
    }()

    let container: NSPersistentContainer // is connected to the file reminder.xcdatamodeld

    init(inMemory: Bool = false) {
        
//      initializing a persistence controller
        container = NSPersistentContainer(name: "reminder")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
//      the primary function is to 'load data from the container'
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
/*
 Typical reasons for an error here include:
 * The parent directory does not exist, cannot be created, or disallows writing.
 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
 * The device is out of space.
 * The store could not be migrated to the current model version.
 Check the error message to determine what the actual problem was.
 */
