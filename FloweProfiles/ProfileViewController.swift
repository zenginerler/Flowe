//
//  ProfileViewController.swift
//  FloweProfiles
//
//  Created by Hiran Manoharan on 11/9/21.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {

    var user = ""
    var userID:NSManagedObjectID? = nil
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var aboutMe: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userVerification()
        fillProfile()
        // Do any additional setup after loading the view.
    }
    
    func fillProfile() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let singleUser = context.object(with: userID!)
        let personProfile = singleUser.value(forKey: "profile") as! NSOrderedSet
        
        let profileNSObj = personProfile.firstObject as! NSManagedObject
        self.username.text = "\(user)"
        self.firstName.text = (profileNSObj.value(forKey: "firstName") as! String)
        self.lastName.text = (profileNSObj.value(forKey: "lastName") as! String)
        self.phoneNumber.text = (profileNSObj.value(forKey: "contactInfo") as! String)
        self.email.text = (profileNSObj.value(forKey: "email") as! String)
        self.aboutMe.text = (profileNSObj.value(forKey: "aboutMe") as! String)
    }
    
    func userVerification() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        var fetchedResults: [NSManagedObject]? = nil

        let predicate = NSPredicate(format: "username MATCHES '\(user)'")
        request.predicate = predicate

        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
            if fetchedResults?.count == 1 {
                userID = fetchedResults!.first!.objectID
            } else {
                debugPrint("Error finding user in CoreData")
                abort()
            }
        } catch {
            let nsError = error as NSError
            NSLog("Unresolved error \(nsError), \(nsError.userInfo)")
            abort()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileEditSegue" {
            let profileEditVC: ProfileEditViewController = segue.destination as! ProfileEditViewController
            profileEditVC.user = self.user
            profileEditVC.userID = self.userID
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
