//
//  Tasks+CoreDataProperties.swift
//  flowe
//
//  Created by Michael Walters on 11/10/21.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var name: String?
    @NSManaged public var dayDue: Int64
    @NSManaged public var monthDue: Int64
    @NSManaged public var yearDue: Int64

}

extension Tasks : Identifiable {

}
