////
////  AddProjectViewController.swift
////  flowe
////
////  Created by Michael Walters on 11/8/21.
////
//
//import UIKit
//import CoreData
//
//class AddProjectViewController: UIViewController {
//
//    @IBOutlet weak var projectNameField: UITextField!
//    @IBOutlet weak var monthSelector: UISegmentedControl!
//    @IBOutlet weak var yearField: UITextField!
//    @IBOutlet weak var dayField: UITextField!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    
//    @IBAction func monthSelected(_ sender: Any) {
//        switch monthSelector.selectedSegmentIndex {
//        case 0:
//            project.due.month = 7
//        case 1:
//            project.due.month = 8
//        case 2:
//            project.due.month = 12
//        default:
//            break
//        }
//    }
//    
//    @IBAction func savePressed(_ sender: Any) {
//        project.name = projectNameField.text!
//        project.due.year = Int(yearField.text!)
//        project.due.day = Int(dayField.text!)
//        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        
//        let projectEntity = NSEntityDescription.insertNewObject(
//            forEntityName:"Project", into: context)
//        projectEntity.setValue(project, forKey: "projectObject")
//        
//        do {
//            try context.save()
//        }
//        
//        catch {
//            // If an error occurs
//            let nserror = error as NSError
//            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
//            abort()
//        }
//    }
//    
//    
//
//}
