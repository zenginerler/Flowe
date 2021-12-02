//
//  ProfileViewController.swift
//  FloweProfiles
//
//  Created by Hiran Manoharan on 11/9/21.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var ProfileInfoView: UIView!
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var aboutMe: UILabel!
    
    @IBOutlet weak var firstNameText: UILabel!
    @IBOutlet weak var lastNameText: UILabel!
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var phoneText: UILabel!
    @IBOutlet weak var aboutText: UILabel!
    
    
    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()

        // Round Label & Image Borders
        roundBorders()

        fillProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fillProfile()
        darkModeCheck()
    }
        
    func fillProfile() {
        let singleUser = context.object(with: Variables.userID!)
        let profileNSObj = singleUser.value(forKey: "profile") as! NSManagedObject
        
        self.username.text = "\(strSplit(str: Variables.username, seperator: "@")[0])"
        self.firstName.text = "  \(profileNSObj.value(forKey: "firstName") as! String)"
        self.lastName.text = "  \(profileNSObj.value(forKey: "lastName") as! String)"
        self.phoneNumber.text = "  \(profileNSObj.value(forKey: "contactInfo") as! String)"
        self.email.text = "  \(profileNSObj.value(forKey: "email") as! String)"
        self.aboutMe.text = "  \(profileNSObj.value(forKey: "aboutMe") as! String)"
    }
    
    func assignBackground() {
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
 
    func roundBorders() {
        // Profile Picture Adjustments
        profilePicture.clipsToBounds = true
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
//        ProfileInfoView.layer.borderWidth = 1
        
        // Label Adjustments
        username.layer.masksToBounds = true
        username.layer.cornerRadius = 6
        firstName.layer.masksToBounds = true
        firstName.layer.cornerRadius = 6
        lastName.layer.masksToBounds = true
        lastName.layer.cornerRadius = 6
        phoneNumber.layer.masksToBounds = true
        phoneNumber.layer.cornerRadius = 6
        email.layer.masksToBounds = true
        email.layer.cornerRadius = 6
        aboutMe.layer.masksToBounds = true
        aboutMe.layer.cornerRadius = 6
    }
    
    func darkModeCheck() {
        // Update the the theme according to user settings
        if (Variables.appTheme == 1) {
            overrideUserInterfaceStyle = .light
            (view.subviews[0] as! UIImageView).image = UIImage(named: "bg_profile_light")
        } else if (Variables.appTheme == 2) {
            overrideUserInterfaceStyle = .dark
            (view.subviews[0] as! UIImageView).image = UIImage(named: "bg_profile_dark")
        } else {
            print("\nTheme ERROR")
        }
    }
    
}
