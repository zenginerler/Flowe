//
//  ProfileViewController.swift
//  FloweProfiles
//
//  Created by Hiran Manoharan on 11/9/21.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var aboutMe: UILabel!
    
    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theme()
        
        profilePicture.clipsToBounds = true
        profilePicture.layer.cornerRadius =  profilePicture.frame.size.height / 2

        fillProfile()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fillProfile()
        theme()
    }
        
    func fillProfile() {
        let singleUser = context.object(with: Variables.userID!)
        let profileNSObj = singleUser.value(forKey: "profile") as! NSManagedObject
        
        self.username.text = "\(Variables.username)"
        self.firstName.text = (profileNSObj.value(forKey: "firstName") as! String)
        self.lastName.text = (profileNSObj.value(forKey: "lastName") as! String)
        self.phoneNumber.text = (profileNSObj.value(forKey: "contactInfo") as! String)
        self.email.text = (profileNSObj.value(forKey: "email") as! String)
        self.aboutMe.text = (profileNSObj.value(forKey: "aboutMe") as! String)
    }
    
    func theme() {
        view.backgroundColor = Variables.backgroundColor
    }
}
