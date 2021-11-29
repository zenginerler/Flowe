//
//  Settings+CoreDataProperties.swift
//  
//
//  Created by Hiran Manoharan on 11/29/21.
//
//

import Foundation
import CoreData


extension Settings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Settings> {
        return NSFetchRequest<Settings>(entityName: "Settings")
    }

    @NSManaged public var backgroundColor: String?
    @NSManaged public var settingsBy: Users?

}
