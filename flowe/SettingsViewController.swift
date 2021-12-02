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
    
    @IBOutlet weak var colorText: UILabel!
    @IBOutlet weak var jingleText: UILabel!
    @IBOutlet weak var sleepText: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBOutlet weak var themeSegment: UISegmentedControl!
    @IBOutlet weak var jingleSegment: UISegmentedControl!
    @IBOutlet weak var sleepSwitch: UISwitch!
    @IBOutlet weak var themeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signOutButton.layer.masksToBounds = true
        signOutButton.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Remember the dark mode button state
        if (Variables.appTheme == 1) {
            themeSwitch.isOn = false
        } else {
            themeSwitch.isOn = true
        }
        darkModeCheck()
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if #available(iOS 13.0, *){
            if (themeSwitch.isOn) {
                Variables.appTheme = 2 // .dark
            } else {
                Variables.appTheme = 1 // .light
            }
        } else {
            // pop up an alert if ios-13 isn't available
            print("dark mode requires IOS 13+")
        }
        darkModeCheck()
    }
    
    @IBAction func themeChange(_ sender: Any) {
        switch themeSegment.selectedSegmentIndex {
           case 0:
            print("option 1")
           case 1:
            print("option 2")
           default:
            print("default option")
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
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
        // Reset App settings
        Variables.username = ""
        Variables.userID = nil
        Variables.appTheme = 1
        Variables.jingle = "song 1"
        Variables.sleep = "sun.png"
    }
    
    func darkModeCheck() {
        // Update the the theme according to user settings
        if (Variables.appTheme == 1) {
            overrideUserInterfaceStyle = .light
        } else if (Variables.appTheme == 2) {
            overrideUserInterfaceStyle = .dark
        } else {
            print("\nTheme ERROR")
        }
    }
    
}
