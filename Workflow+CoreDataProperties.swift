//
//  Workflow+CoreDataProperties.swift
//  
//
//  Created by Hiran Manoharan on 12/3/21.
//
//

import Foundation
import CoreData


extension Workflow {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workflow> {
        return NSFetchRequest<Workflow>(entityName: "Workflow")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var task: String?
    @NSManaged public var userWorkflow: Users?

}
