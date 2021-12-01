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
    static var username = "nothing"
    static var userID:NSManagedObjectID? = nil
    
    // Color Variables
    static let kUserTheme = "pageTheme"
    static var pageTheme = "light"
    static let defaults = UserDefaults.standard
    
    static let white = [NSAttributedString.Key.foregroundColor: UIColor.white]
    static let black = [NSAttributedString.Key.foregroundColor: UIColor.black]
    static let gray = UIColor.darkGray
    
    //Jingle Variable
    static var jingle = "song 1"
    
    // Sleep icon
    static var sleep = "sun.png"
}
