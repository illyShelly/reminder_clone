//
//  Listing+CoreDataProperties.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 29/11/2022.
//
//

import Foundation
import CoreData


extension Listing {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Listing> {
        return NSFetchRequest<Listing>(entityName: "Listing")
    }
    
    @NSManaged public var colorCode: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var reminders: NSSet?
    
    public var wrappedColorCode: String {
        colorCode ?? "#00C7BE"
    }
    public var wrappedIcon: String {
        icon ?? "circle.fill"
    }
    public var wrappedName: String {
        name ?? "Unknown List"
    }
    //    Sorting Set -> creates array
    public var remindersArr: [Reminder] {
        // trying to convert NSSet to Reminder -> otherwise empty set []
        let set = reminders as? Set<Reminder> ?? []  //if 'as? Set<Reminder>' is nil -> return empty one
        
        return set.sorted {
            $0.wrappedTitle < $1.wrappedTitle
        }
    }
}

// MARK: Generated accessors for reminders
extension Listing {

    @objc(addRemindersObject:)
    @NSManaged public func addToReminders(_ value: Reminder)

    @objc(removeRemindersObject:)
    @NSManaged public func removeFromReminders(_ value: Reminder)

    @objc(addReminders:)
    @NSManaged public func addToReminders(_ values: NSSet)

    @objc(removeReminders:)
    @NSManaged public func removeFromReminders(_ values: NSSet)

}

extension Listing : Identifiable {

}
