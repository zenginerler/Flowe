//
//  GoalViewController.swift
//  flowe
//
//  Created by Yixing Ma on 11/8/21.
//

import UIKit
import CoreData
import EventKit

class goal {
    var type_g = ""
    var content_g = ""
    var title_g = ""
    var date_g = ""
}

class GoalViewController: UIViewController {
    var delegate: GoalListViewController!
    var type: String = ""
    let eventStore = EKEventStore()
    var savedEventId:String = ""
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var journalStatusLabel: UILabel!
    @IBOutlet weak var goalContent: UITextField!
    @IBOutlet weak var addToJournalButton: UIButton!
    @IBOutlet weak var addToCalendarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        addToJournalButton.layer.cornerRadius = 10
        addToCalendarButton.layer.cornerRadius = 10
        goalContent.layer.masksToBounds = true
        goalContent.layer.cornerRadius = 12
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        darkModeCheck()
        
    }

    @IBAction func typeActionsheet(_ sender: Any) {
        let actionsheet1 = UIAlertController(
            title: "Select type",
            message: "Choose a journal type:",
            preferredStyle: .actionSheet)
        
        let WorkAction = UIAlertAction(
            title: "Daily",
            style: .default,
            handler:{_ in self.type = "Daily"})
        actionsheet1.addAction(WorkAction)
        
        let RelationshipAction = UIAlertAction(
            title: "Vent",
            style: .default,
            handler:{_ in self.type = "Vent"})
        actionsheet1.addAction(RelationshipAction)
        
        let EducationAction = UIAlertAction(
            title: "Gratitude",
            style: .default,
            handler:{_ in self.type = "Gratitude"})
        actionsheet1.addAction(EducationAction)
        
        let SelfgrowthAction = UIAlertAction(
            title: "Expectation",
            style: .default,
            handler:{_ in self.type = "Expectation"})
        actionsheet1.addAction(SelfgrowthAction)
        
        present(actionsheet1, animated: true, completion: nil)
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
    func darkModeCheck() {
        // Update the the theme according to user settings
        if (Variables.appTheme == 1) {
            overrideUserInterfaceStyle = .light
            (view.subviews[0] as! UIImageView).image = UIImage(named: "bg_3_light")
        } else if (Variables.appTheme == 2) {
            overrideUserInterfaceStyle = .dark
            (view.subviews[0] as! UIImageView).image = UIImage(named: "bg_3_dark")
        } else {
            print("\nTheme ERROR")
        }
    }
    
    
    @IBAction func AddButton(_ sender: Any) {
        var newGoal: goal
        newGoal = goal()
        newGoal.type_g = self.type
        newGoal.content_g = self.goalContent.text ?? ""
        newGoal.title_g = self.titleTextField.text ?? ""
        newGoal.date_g = self.dateTextField.text ?? ""
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let goall = NSEntityDescription.insertNewObject(
            forEntityName: "Goals", into: context)
        
        // store values in Core data
        goall.setValue(newGoal.type_g, forKey: "type")
        goall.setValue(newGoal.content_g, forKey: "content")
        goall.setValue(newGoal.title_g, forKey: "title")
        goall.setValue(newGoal.date_g, forKey: "date")
        
        print(goall)
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
    }
    
    func createEvent(title:String, startDate:NSDate, endDate:NSDate) {
        
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title
        event.startDate = startDate as Date?
        event.endDate = endDate as Date?
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(event, span: .thisEvent)
            savedEventId = event.eventIdentifier
            journalStatusLabel.text = "Event added to calendar"
        } catch {
            print("Error")
        }
    }
    
    
    @IBAction func addToCalendarButton(_ sender: Any) {
        
        let startDate = NSDate()
        let endDate = startDate.addingTimeInterval(60*60)
        let content = goalContent.text
        
        if (EKEventStore.authorizationStatus(for: .event) != .authorized) {
            eventStore.requestAccess(to: .event, completion: {
                granted, error in
                self.createEvent(title: "\(content ?? "")", startDate: startDate, endDate: endDate)
            })
        } else {
            createEvent(title: "\(content ?? "")", startDate: startDate, endDate: endDate)
        }
        
    }
    
//    func darkModeCheck() {
//        // Update the the theme according to user settings
//        if (Variables.appTheme == 1) {
//            overrideUserInterfaceStyle = .light
//        } else if (Variables.appTheme == 2) {
//            overrideUserInterfaceStyle = .dark
//        } else {
//            print("\nTheme ERROR")
//        }
//    }
    
}
