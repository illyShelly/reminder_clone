//
//  Reminder+CoreDataProperties.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 29/11/2022.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: UUID?
    @NSManaged public var origin: Listing?
    
    public var wrappedTitle: String {
        title ?? "Unknown Reminder"
    }
}

extension Reminder : Identifiable {

}
