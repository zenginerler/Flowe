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
    
    @IBOutlet weak var colorText: UILabel!
    @IBOutlet weak var jingleText: UILabel!
    @IBOutlet weak var sleepText: UILabel!
    

    
    @IBOutlet weak var themeSegment: UISegmentedControl!
    @IBOutlet weak var jingleSegment: UISegmentedControl!
    @IBOutlet weak var sleepSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDefaultSegments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setDefaultSegments()
        theme()
    }
    
    func setDefaultSegments() {
        if Variables.pageTheme == "light" {
            themeSegment.selectedSegmentIndex = 0
        } else if Variables.pageTheme == "dark" {
            themeSegment.selectedSegmentIndex = 1
        }
    }
    
    @IBAction func themeChange(_ sender: Any) {
        switch themeSegment.selectedSegmentIndex {
           case 0:
                Variables.pageTheme = "light"
                theme()
           case 1:
                Variables.pageTheme = "dark"
                theme()
           default:
                Variables.pageTheme = "light"
                theme()
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
    
    func theme() {
        if Variables.pageTheme == "light" {
            view.backgroundColor = UIColor.white
            
            self.colorText.textColor = UIColor.black
            self.jingleText.textColor = UIColor.black
            self.sleepText.textColor = UIColor.black
            
            self.themeSegment.setTitleTextAttributes(Variables.black, for: .normal)
            self.themeSegment.setTitleTextAttributes(Variables.black, for: .selected)
            
            self.jingleSegment.setTitleTextAttributes(Variables.black, for: .normal)
            self.jingleSegment.setTitleTextAttributes(Variables.black, for: .selected)
            
            navigationController?.navigationBar.titleTextAttributes = Variables.black
            
        } else if Variables.pageTheme == "dark" {
            view.backgroundColor = Variables.gray
            
            self.colorText.textColor = UIColor.white
            self.jingleText.textColor = UIColor.white
            self.sleepText.textColor = UIColor.white
            
            self.themeSegment.setTitleTextAttributes(Variables.white, for: .normal)
            self.themeSegment.setTitleTextAttributes(Variables.black, for: .selected)
            
            self.jingleSegment.setTitleTextAttributes(Variables.white, for: .normal)
            self.jingleSegment.setTitleTextAttributes(Variables.black, for: .selected)
        
            navigationController?.navigationBar.titleTextAttributes = Variables.white
        }
            
    }
    

}
