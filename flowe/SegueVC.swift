//
//  ViewController.swift
//  flowe
//
//  Created by Mehmet Yavuz Zenginerler on 11/4/21.
//

import UIKit
import CoreData
//import SwiftUI

class SegueVC: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    
    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
//        @IBOutlet weak var theContainer: UIView!
//        // Necessary code to upload the swiftUI file (login.swift)
//        let childView = UIHostingController(rootView: LoginUI())
//        addChild(childView)
//        childView.view.frame = theContainer.bounds
//        theContainer.addSubview(childView.view)
        
        homeButton.layer.cornerRadius = 10
    }

    
    @IBAction func userInitiation(_ sender: Any) {
        let request = Users.fetchRequest() as NSFetchRequest<Users>
        var fetchedResults: [Users]?

        let predicate = NSPredicate(format: "username MATCHES '\(Variables.username)'")
        request.predicate = predicate

        do {
            fetchedResults = try context.fetch(request)

            if fetchedResults?.count == 1 {
                Variables.userID = fetchedResults!.first!.objectID
            } else if fetchedResults?.count == 0 {
                let username = Users(context: self.context)
                username.username = Variables.username
                
                let defaultProfile = Profile(context: self.context)
                defaultProfile.firstName = "Please Edit First Name"
                defaultProfile.lastName = "Please Edit Last Name"
                defaultProfile.email = "Please Edit Email"
                defaultProfile.aboutMe = "Please Edit About Me"
                defaultProfile.contactInfo = "Please Edit Phone Number"
                defaultProfile.userProfile = username
                username.profile = defaultProfile

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

