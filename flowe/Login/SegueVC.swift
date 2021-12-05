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

    var animationView: AnimationView?
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var homeButton: UIButton!
    
    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        homeButton.layer.cornerRadius = 10
        
        // Lottie Animation Settings
        animationView = .init(name: "workflow")
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1
        animationView?.frame = wrapperView.bounds
        wrapperView.addSubview(animationView!)
        
        
        // Gesture settings:
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(gestureSwipeLeft(recognizer:)))
        swipeLeftRecognizer.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeftRecognizer)
        
        // Initiate the user or retrieve the existing user data
        userInitiation()
        
        // Update the Dark Mode choices from user defaults
        Variables.appTheme = Variables.defaults.integer(forKey: Variables.userTheme)
        
        // Update Sleep Mode choice
        Variables.isMuted = Variables.defaults.bool(forKey: "sleepMode")
        
        Variables.avatar = (Variables.defaults.string(forKey: "avatar") ?? "sun")
    }
    
    // Change the page with right swipe
    @IBAction func gestureSwipeLeft(recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            self.performSegue(withIdentifier: "getStarted", sender: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        darkModeCheck()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationView?.play()
    }

    
    // Initialize User Defaults
    func userInitiation() {
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
                defaultProfile.firstName = "New"
                defaultProfile.lastName = "User"
                defaultProfile.email = Variables.username
                defaultProfile.aboutMe = "A new Flowe User"
                defaultProfile.contactInfo = "555-555-5555"
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

// String splitter
func strSplit(str: String, seperator: String) -> [String] {
    return str.components(separatedBy: seperator)
}
