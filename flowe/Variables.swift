//
//  Variables.swift
//  flowe
//
//  Created by Hiran Manoharan on 11/26/21.
//

import Foundation
import UIKit
import CoreData

class Variables: UIViewController {
    // Username string variable
    static var username = ""
    static var userID:NSManagedObjectID? = nil
    static var firstName = "New User"
    
    // Color Variables
    static var appTheme = 1 // Default app theme = .light
    
    //Jingle Variable
    static var jingle = "song 1"
    
    // Sleep icon
    static var sleep = "sun.png"
    
    // remove project variable
    static var removeProject = false
    
    // delete project variable
    static var deleteProject = false
    
    // sound for home launch
    static var sound = "fairy"
}
