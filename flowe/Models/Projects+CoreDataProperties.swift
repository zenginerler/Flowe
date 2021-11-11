//
//  Projects+CoreDataProperties.swift
//  flowe
//
//  Created by Michael Walters on 11/10/21.
//
//

import Foundation
import CoreData


extension Projects {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Projects> {
        return NSFetchRequest<Projects>(entityName: "Projects")
    }

    @NSManaged public var about: String?
    @NSManaged public var dateDue: Int64
    @NSManaged public var name: String?
    @NSManaged public var team: [Users]?
    @NSManaged public var yearDue: Int64
    @NSManaged public var monthDue: Int64
    @NSManaged public var tasks: [Tasks]?
    @NSManaged public var assignedTo: Users?
    @NSManaged public var createdBy: Users?

}

extension Projects : Identifiable {

}
