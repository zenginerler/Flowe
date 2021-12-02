//
//  ProfileEditViewController.swift
//  FloweProfiles
//
//  Created by Hiran Manoharan on 11/9/21.
//

import UIKit
import CoreData

class ProfileEditViewController: UIViewController {
    
    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var aboutMeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        darkModeCheck()
    }
    
    func fillTextFields() {
        let singleUser = context.object(with: Variables.userID!)
        let profileNSObj = singleUser.value(forKey: "profile") as! NSManagedObject
    
        self.usernameLabel.text = "\(Variables.username)"
        self.firstNameTextField.placeholder = "  \(profileNSObj.value(forKey: "firstName") as! String)"
        self.lastNameTextField.placeholder = "  \(profileNSObj.value(forKey: "lastName") as! String)"
        self.phoneNumberTextField.placeholder = "  \(profileNSObj.value(forKey: "contactInfo") as! String)"
        self.emailTextField.placeholder = "  \(profileNSObj.value(forKey: "email") as! String)"
        self.aboutMeTextField.placeholder = "  \(profileNSObj.value(forKey: "aboutMe") as! String)"
    }
    
    @IBAction func saveProfile(_ sender: Any) {
        let singleUser = context.object(with: Variables.userID!)
        let profileNSObj = singleUser.value(forKey: "profile") as! NSManagedObject
        
        profileNSObj.setValue(singleUser, forKey: "userProfile")
        profileNSObj.setValue(self.firstNameTextField.text, forKey: "firstName")
        profileNSObj.setValue(self.lastNameTextField.text, forKey: "lastName")
        profileNSObj.setValue(self.phoneNumberTextField.text, forKey: "contactInfo")
        profileNSObj.setValue(self.emailTextField.text, forKey: "email")
        profileNSObj.setValue(self.aboutMeTextField.text, forKey: "aboutMe")
        
        // Commit the changes
        do {
            try singleUser.managedObjectContext?.save()
        } catch {
            // If an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
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
