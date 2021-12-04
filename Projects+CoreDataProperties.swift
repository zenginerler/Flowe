//
//  Projects+CoreDataProperties.swift
//  
//
//  Created by Hiran Manoharan on 12/3/21.
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
    @NSManaged public var due: Date?
    @NSManaged public var finished: Bool
    @NSManaged public var monthDue: Int64
    @NSManaged public var name: String?
    @NSManaged public var owner: String?
    @NSManaged public var tasks: [Tasks]?
    @NSManaged public var team: [Users]?
    @NSManaged public var yearDue: Int64
    @NSManaged public var assignedTo: Users?
    @NSManaged public var createdBy: Users?

}
