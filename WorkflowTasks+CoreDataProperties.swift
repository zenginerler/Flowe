//
//  WorkflowTasks+CoreDataProperties.swift
//  
//
//  Created by Hiran Manoharan on 12/5/21.
//
//

import Foundation
import CoreData


extension WorkflowTasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkflowTasks> {
        return NSFetchRequest<WorkflowTasks>(entityName: "WorkflowTasks")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var task: String?
    @NSManaged public var title: String?
    @NSManaged public var userWorkflow: Users?

}
