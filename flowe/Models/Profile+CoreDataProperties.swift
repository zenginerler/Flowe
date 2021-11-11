//
//  Profile+CoreDataProperties.swift
//  flowe
//
//  Created by Michael Walters on 11/10/21.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var aboutMe: String?
    @NSManaged public var contactInfo: String?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var userProfile: Users?

}

extension Profile : Identifiable {

}
