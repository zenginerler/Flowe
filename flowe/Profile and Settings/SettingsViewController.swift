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
    
    @IBOutlet weak var themeSegment: UISegmentedControl!
    @IBOutlet weak var jingleSegment: UISegmentedControl!
    @IBOutlet weak var sleepSwitch: UISwitch!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var avatarSelection: UISegmentedControl!
    
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        assignbackground()
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
        
        // sleep switch default state
        if Variables.isMuted{
            sleepSwitch.isOn = true
        }
        else{
            sleepSwitch.isOn = false
        }
        
        //jingle selector default state
        if (Variables.defaults.string(forKey: "appSound")) == "bells"{
            jingleSegment.selectedSegmentIndex = 0
        }
        else if (Variables.defaults.string(forKey: "appSound")) == "fairy"{
            jingleSegment.selectedSegmentIndex = 1
        }
        else{
            jingleSegment.selectedSegmentIndex = 2
        }
        
        //avatar default state
        if Variables.avatar == "sun"{
            avatarSelection.selectedSegmentIndex = 0
        }
        else if Variables.avatar == "moon"{
            avatarSelection.selectedSegmentIndex = 1
        }
        else{
            avatarSelection.selectedSegmentIndex = 2
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
            Variables.defaults.set("bells", forKey: "appSound")
        case 1:
            playSound(file: "fairy")
            Variables.defaults.set("fairy", forKey: "appSound")
        case 2:
            playSound(file: "flute")
            Variables.defaults.set("flute", forKey: "appSound")
        default:
            playSound(file: "bells")
            Variables.defaults.set("bells", forKey: "appSound")
        }
    }
    
    @IBAction func avatarSelected(_ sender: Any) {
        switch avatarSelection.selectedSegmentIndex {
        case 0:
            Variables.defaults.set("sun", forKey: "avatar")
            Variables.avatar = "sun"
            print("avatar set to \(Variables.avatar)")
        case 1:
            Variables.defaults.set("moon", forKey: "avatar")
            Variables.avatar = "moon"
        case 2:
            Variables.defaults.set("earth", forKey: "avatar")
            Variables.avatar = "earth"
        default:
            Variables.defaults.set("sun", forKey: "avatar")
            Variables.avatar = "sun"
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
            Variables.isMuted = true
            Variables.defaults.set(true, forKey: "sleepMode")
        } else {
            Variables.isMuted = false
            Variables.defaults.set(false, forKey: "sleepMode")
        }
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
        // Reset App settings
        Variables.username = ""
        Variables.userID = nil
        Variables.appTheme = 1
    }
    
    func assignbackground() {
          let background = UIImage()

          var imageView : UIImageView!
          imageView = UIImageView(frame: view.bounds)
          imageView.contentMode =  UIView.ContentMode.scaleAspectFill
          imageView.clipsToBounds = true
          imageView.image = background
          imageView.center = view.center
          view.addSubview(imageView)
          self.view.sendSubviewToBack(imageView)
      }
    
    func darkModeCheck() {
        // Update the the theme according to user settings
        if (Variables.appTheme == 1) {
            overrideUserInterfaceStyle = .light
//            (view.subviews[0] as! UIImageView).image = UIImage(named: "sharp_light")
        } else if (Variables.appTheme == 2) {
            overrideUserInterfaceStyle = .dark
//            (view.subviews[0] as! UIImageView).image = UIImage(named: "sharp_dark")
        } else {
            print("\nTheme ERROR")
        }
    }
    
    
}
