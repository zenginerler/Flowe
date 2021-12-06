//
//  GoalListViewController.swift
//  flowe
//
//  Created by Yixing Ma on 11/9/21.
//

import UIKit
import CoreData

var goallist: [NSManagedObject] = []

class GoalListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let goalIdentifier = "goalIdentifier"
    let goalSegueIdentifier = "goalSegueIdentifier"
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        assignBackground()
        view.backgroundColor = UIColor.init(named: "custom_logo_blues")
        tableView.backgroundColor = UIColor.init(named: "custmo_logo_light_blues")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        goallist = retrievePizza()
        self.tableView.reloadData()
        
        darkModeCheck()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goallist.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: goalIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.init(named: "custom_logo_blues")
        let row = indexPath.row
        // put the value in table view from core data.
        let typee = goallist[row].value(forKey: "type")
        let contentt = goallist[row].value(forKey: "content")
        let titlee = goallist[row].value(forKey: "title")
        let datee = goallist[row].value(forKey: "date")
        let goalintable = "\(datee ?? "")\n   \(titlee ?? "")\n   \(typee ?? "")\n   \(contentt ?? "")"
        cell.textLabel?.text = goalintable
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            goallist.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            // delete one core data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Goals")
            var fetchedResults:[NSManagedObject]
            do {
                try fetchedResults = context.fetch(request) as! [NSManagedObject]
                if fetchedResults.count > 0 {
                    context.delete(fetchedResults[indexPath.row])
                }
                try context.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        } else if editingStyle == .insert {
        }
    }
    
    func retrievePizza() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Goals")
        var fetchedResults:[NSManagedObject]? = nil
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        return(fetchedResults)!
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goalSegueIdentifier",
           let destination = segue.destination as? GoalViewController
        {
            destination.delegate = self
        }
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
