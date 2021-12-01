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
}

class GoalViewController: UIViewController {
    var delegate: GoalListViewController!
    var type: String = ""
    let eventStore = EKEventStore()
    var savedEventId:String = ""
    
    @IBOutlet weak var journalStatusLabel: UILabel!
    @IBOutlet weak var goalContent: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func typeActionsheet(_ sender: Any) {
        let actionsheet1 = UIAlertController(
            title: "Select type",
            message: "Choose a goal type:",
            preferredStyle: .actionSheet)
        
        let WorkAction = UIAlertAction(
            title: "Work",
            style: .default,
            handler:{_ in self.type = "Work"})
        actionsheet1.addAction(WorkAction)
        
        let RelationshipAction = UIAlertAction(
            title: "Relationship",
            style: .default,
            handler:{_ in self.type = "Relationship"})
        actionsheet1.addAction(RelationshipAction)
        
        let EducationAction = UIAlertAction(
            title: "Education",
            style: .default,
            handler:{_ in self.type = "Education"})
        actionsheet1.addAction(EducationAction)
        
        let SelfgrowthAction = UIAlertAction(
            title: "Self Growth",
            style: .default,
            handler:{_ in self.type = "Self Growth"})
        actionsheet1.addAction(SelfgrowthAction)
        
        present(actionsheet1, animated: true, completion: nil)
    }
    
    
    @IBAction func AddButton(_ sender: Any) {
        let startDate = NSDate()
        let endDate = startDate.addingTimeInterval(60*60)
        
        if (EKEventStore.authorizationStatus(for: .event) != .authorized) {
            eventStore.requestAccess(to: .event, completion: {
                granted, error in
                self.createEvent(title: "Polish my bowling trophies", startDate: startDate, endDate: endDate)
            })
        } else {
            createEvent(title: "Polish my bowling trophies", startDate: startDate, endDate: endDate)
        }
        var newGoal: goal
        newGoal = goal()
        newGoal.type_g = self.type
        newGoal.content_g = self.goalContent.text ?? ""
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let goall = NSEntityDescription.insertNewObject(
            forEntityName: "Goals", into: context)
        
        
        // store values in Core data
        goall.setValue(newGoal.type_g, forKey: "type")
        goall.setValue(newGoal.content_g, forKey: "content")
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

    
}
