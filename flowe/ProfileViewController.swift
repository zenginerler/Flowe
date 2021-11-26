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
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            profilePicture.clipsToBounds = true
            profilePicture.layer.cornerRadius =  profilePicture.frame.size.height / 2

            userVerification()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            let singleUser = context.object(with: Variables.userID!)
            let profileObject = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: context)

            profileObject.setValue(singleUser, forKey: "profile")
            profileObject.setValue("This is about me", forKey: "aboutMe")
            profileObject.setValue("123-456-789", forKey: "contactInfo")
            profileObject.setValue("me@gmail.com", forKey: "email")
            profileObject.setValue("Spongebob", forKey: "firstName")
            profileObject.setValue("Squarepants", forKey: "lastName")

            print("-----")
            print(profileObject.value(forKey: "firstName") as! String)
            print("-----")
            
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                NSLog("Unresolved error \(nsError), \(nsError.userInfo)")
                abort()
            }
            
            fillProfile()
            // Do any additional setup after loading the view.
        }
        
        func fillProfile() {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            let singleUser = context.object(with: Variables.userID!)
            let personProfiles = singleUser.value(forKey: "profile") as! NSOrderedSet
            
            let profileNSObj = personProfiles.firstObject! as! NSManagedObject
            self.username.text = "\(Variables.username)"
            self.firstName.text = (profileNSObj.value(forKey: "firstName") as! String)
            self.lastName.text = (profileNSObj.value(forKey: "lastName") as! String)
            self.phoneNumber.text = (profileNSObj.value(forKey: "contactInfo") as! String)
            self.email.text = (profileNSObj.value(forKey: "email") as! String)
            self.aboutMe.text = (profileNSObj.value(forKey: "aboutMe") as! String)
        }
        
        func userVerification() {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
        
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            var fetchedResults: [NSManagedObject]? = nil

            let predicate = NSPredicate(format: "username MATCHES '\(Variables.username)'")
            request.predicate = predicate

            do {
                try fetchedResults = context.fetch(request) as? [NSManagedObject]
                if fetchedResults?.count == 1 {
                    Variables.userID = fetchedResults!.first!.objectID
                } else if fetchedResults?.count == 0 {
                    let username = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
                    username.setValue(Variables.username, forKey: "username")
                    username.setValue(NSOrderedSet(), forKey: "profile")
                    
                    do {
                        try context.save()
                    } catch {
                        let nsError = error as NSError
                        NSLog("Unresolved error \(nsError), \(nsError.userInfo)")
                        abort()
                    }
                    
                    Variables.userID = username.objectID
                    
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
    }
