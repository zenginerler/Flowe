//
//  SettingsViewController.swift
//  flowe
//
//  Created by Hiran Manoharan on 11/26/21.
//

import UIKit
import CoreData
import AVFoundation

class SettingsViewController: UIViewController {

    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    
//    @IBOutlet weak var colorText: UILabel!
    @IBOutlet weak var jingleText: UILabel!
    @IBOutlet weak var sleepText: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    
//    @IBOutlet weak var themeSegment: UISegmentedControl!
    @IBOutlet weak var jingleSegment: UISegmentedControl!
    @IBOutlet weak var sleepSwitch: UISwitch!
    @IBOutlet weak var themeSwitch: UISwitch!
    
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signOutButton.layer.masksToBounds = true
        signOutButton.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        darkModeCheck()
        
        // Remember the dark mode button state
        if (Variables.defaults.integer(forKey: Variables.userTheme) == 1) {
            themeSwitch.isOn = false
        } else {
            themeSwitch.isOn = true
        }
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if #available(iOS 13.0, *){
            if (themeSwitch.isOn) {
                Variables.appTheme = 2 // .dark
                Variables.defaults.set(Variables.appTheme, forKey: Variables.userTheme)
            } else {
                Variables.appTheme = 1 // .light
                Variables.defaults.set(Variables.appTheme, forKey: Variables.userTheme)
            }
        } else {
            // pop up an alert if ios-13 isn't available
            print("dark mode requires IOS 13+")
        }
        darkModeCheck()
    }
    
    
    @IBAction func jingleChange(_ sender: Any) {
        switch jingleSegment.selectedSegmentIndex {
        case 0:
            playSound(file: "bells")
            // save to user defaults
        case 1:
            playSound(file: "fairy")
        case 2:
            playSound(file: "flute")
        default:
            playSound(file: "bells")
        }
    }
    
    func playSound(file: String){
        let pathToSound = Bundle.main.path(forResource: file, ofType: "mp3")!
        let url = URL(fileURLWithPath: pathToSound)
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer!.play()
        }
        catch{
            
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
