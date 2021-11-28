//
//  ViewController.swift
//  flowe
//
//  Created by Mehmet Yavuz Zenginerler on 11/4/21.
//

import UIKit
import CoreData
import Lottie


class SegueVC: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var homeButton: UIButton!
    
    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
//          import SwiftUI
//          @IBOutlet weak var theContainer: UIView!
//        // Necessary code to upload the swiftUI file (login.swift)
//        let childView = UIHostingController(rootView: LoginUI())
//        addChild(childView)
//        childView.view.frame = theContainer.bounds
//        theContainer.addSubview(childView.view)
        
        homeButton.layer.cornerRadius = 10
        
        // Lottie Animation Settings
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        
        // Gesture settings:
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(gestureSwipeLeft(recognizer:)))
        swipeLeftRecognizer.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeftRecognizer)
    }
    
    // Change the page with right swipe
    @IBAction func gestureSwipeLeft(recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            self.performSegue(withIdentifier: "getStarted", sender: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationView.play()
    }

    
    // Initialize User Defaults
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
                let currentUser = Users(context: self.context)
                currentUser.username = Variables.username
                
                let defaultProfile = Profile(context: self.context)
                defaultProfile.firstName = "not specified"
                defaultProfile.lastName = "not specified"
                defaultProfile.email = Variables.username
                defaultProfile.aboutMe = "not specified"
                defaultProfile.contactInfo = "not specified"
                defaultProfile.userProfile = currentUser
                currentUser.profile = defaultProfile

                do {
                    try context.save()
                } catch {
                    let nsError = error as NSError
                    NSLog("Unresolved error \(nsError), \(nsError.userInfo)")
                    abort()
                }

                Variables.userID = currentUser.objectID

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

// String splitter
func strSplit(str: String, seperator: String) -> [String] {
    return str.components(separatedBy: seperator)
}
