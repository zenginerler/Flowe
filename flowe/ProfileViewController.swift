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
        theme()
        
        profilePicture.clipsToBounds = true
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        ProfileInfoView.layer.borderWidth = 1
        
        // Round Label Borders
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

        fillProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fillProfile()
        theme()
    }
        
    func fillProfile() {
        let singleUser = context.object(with: Variables.userID!)
        let profileNSObj = singleUser.value(forKey: "profile") as! NSManagedObject
        
        self.username.text = "\(strSplit(str: Variables.username, seperator: "@")[0])"
        self.firstName.text = (profileNSObj.value(forKey: "firstName") as! String)
        self.lastName.text = (profileNSObj.value(forKey: "lastName") as! String)
        self.phoneNumber.text = (profileNSObj.value(forKey: "contactInfo") as! String)
        self.email.text = (profileNSObj.value(forKey: "email") as! String)
        self.aboutMe.text = (profileNSObj.value(forKey: "aboutMe") as! String)
    }
    
    func theme() {
        if Variables.defaults.string(forKey: Variables.kUserTheme) == "light" {
            view.backgroundColor = UIColor.white
            
            self.usernameText.textColor = UIColor.black
            self.username.textColor = UIColor.black
            self.firstName.textColor = UIColor.black
            self.lastName.textColor = UIColor.black
            self.phoneNumber.textColor = UIColor.black
            self.email.textColor = UIColor.black
            self.aboutMe.textColor = UIColor.black
            
            self.firstNameText.textColor = UIColor.black
            self.lastNameText.textColor = UIColor.black
            self.emailText.textColor = UIColor.black
            self.phoneText.textColor = UIColor.black
            self.aboutText.textColor = UIColor.black
            
            
            self.firstName.backgroundColor = UIColor.white
            self.lastName.backgroundColor = UIColor.white
            self.phoneNumber.backgroundColor = UIColor.white
            self.email.backgroundColor = UIColor.white
            self.aboutMe.backgroundColor = UIColor.white
            
            navigationController?.navigationBar.titleTextAttributes = Variables.black
            
        } else if Variables.defaults.string(forKey: Variables.kUserTheme) == "dark" {
            view.backgroundColor = UIColor.darkGray
            
            self.usernameText.textColor = UIColor.white
            self.username.textColor = UIColor.white
            self.firstName.textColor = UIColor.white
            self.lastName.textColor = UIColor.white
            self.phoneNumber.textColor = UIColor.white
            self.email.textColor = UIColor.white
            self.aboutMe.textColor = UIColor.white
            
            self.firstNameText.textColor = UIColor.white
            self.lastNameText.textColor = UIColor.white
            self.emailText.textColor = UIColor.white
            self.phoneText.textColor = UIColor.white
            self.aboutText.textColor = UIColor.white
            
            self.firstName.backgroundColor = UIColor.black
            self.lastName.backgroundColor = UIColor.black
            self.phoneNumber.backgroundColor = UIColor.black
            self.email.backgroundColor = UIColor.black
            self.aboutMe.backgroundColor = UIColor.black
        
            navigationController?.navigationBar.titleTextAttributes = Variables.white
        }
    }
}
