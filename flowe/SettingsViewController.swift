//
//  SettingsViewController.swift
//  flowe
//
//  Created by Hiran Manoharan on 11/26/21.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var themeSegment: UISegmentedControl!
    
    @IBOutlet weak var jingleSegment: UISegmentedControl!
    
    @IBOutlet weak var sleepSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func themeChange(_ sender: Any) {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
