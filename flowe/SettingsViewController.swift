//
//  SettingsViewController.swift
//  flowe
//
//  Created by Hiran Manoharan on 11/26/21.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {

    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    
    var pageTheme = ""
    
    @IBOutlet weak var themeSegment: UISegmentedControl!
    @IBOutlet weak var jingleSegment: UISegmentedControl!
    @IBOutlet weak var sleepSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultSegments()
        
    }
    
    func setDefaultSegments() {
        let singleUser = context.object(with: Variables.userID!)
        let settingsNSObj = singleUser.value(forKey: "createdSettings") as! NSManagedObject

        pageTheme = (settingsNSObj.value(forKey: "backgroundColor") as! String)
        
        if pageTheme == "light" {
            themeSegment.selectedSegmentIndex = 0
        } else if pageTheme == "dark" {
            themeSegment.selectedSegmentIndex = 1
        }
    }
    
    @IBAction func themeChange(_ sender: Any) {
        let currentUser = Users(context: self.context)
        currentUser.username = Variables.username
        
        let defaultTheme = Settings(context: self.context)
        defaultTheme.backgroundColor = "light"
        currentUser.createdSettings = defaultTheme

        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            NSLog("Unresolved error \(nsError), \(nsError.userInfo)")
            abort()
        }
        
        switch themeSegment.selectedSegmentIndex {
           case 0:
               Variables.backgroundColor = UIColor.white
           case 1:
               Variables.backgroundColor = UIColor.black
           default:
               Variables.backgroundColor = UIColor.white
           }
    }
    
    @IBAction func jingleChange(_ sender: Any) {
        switch jingleSegment.selectedSegmentIndex {
        case 0:
            Variables.jingle = "Song 1"
        case 1:
            Variables.jingle = "Song 2"
        case 2:
            Variables.jingle = "Song 3"
        default:
            Variables.jingle = "Song 1"
        }
    }
    
    @IBAction func sleepChange(_ sender: Any) {
        if sleepSwitch.isOn {
            Variables.sleep = "moon.png"
        } else {
            Variables.sleep = "sun.png"
        }
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        Variables.username = ""
    }
    

}
