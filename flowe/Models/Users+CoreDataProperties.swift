//
//  Users+CoreDataProperties.swift
//  flowe
//
//  Created by Michael Walters on 11/10/21.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var username: String?
    @NSManaged public var assignedProjects: Projects?
    @NSManaged public var createdProjects: Projects?
    @NSManaged public var profile: Profile?

}

extension Users : Identifiable {

}
