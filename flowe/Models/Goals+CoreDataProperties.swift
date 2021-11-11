//
//  Goals+CoreDataProperties.swift
//  flowe
//
//  Created by Michael Walters on 11/10/21.
//
//

import Foundation
import CoreData


extension Goals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goals> {
        return NSFetchRequest<Goals>(entityName: "Goals")
    }

    @NSManaged public var type: String?
    @NSManaged public var content: String?

}

extension Goals : Identifiable {

}
