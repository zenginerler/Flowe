//
//  ProjectsViewController.swift
//  Flowe
//
//  Created by Michael Walters on 11/2/21.
//

import UIKit
import Foundation
import CoreData

class ProjectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var projectsTableView: UITableView!
    @IBOutlet weak var addProjecButton: UIBarButtonItem!
    var projects: [Projects]?
    
    let userCalendar = Calendar(identifier: .gregorian)
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        projectsTableView.delegate = self
        projectsTableView.dataSource = self
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        getProjects()
    }
    
    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    
    func getProjects() {
        try! projects = self.context.fetch(Projects.fetchRequest())
        //Update UI in queue
        DispatchQueue.main.async {
            self.projectsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        let project = self.projects![indexPath.row]
        var dueDate = DateComponents()
        dueDate.month = Int(project.monthDue)
        dueDate.day = Int(project.dateDue)
        dueDate.year = Int(project.yearDue)
        let dateDue = userCalendar.date(from: dueDate)
        let datetime = formatter.string(from: dateDue!)
        let name = project.name!
        cell.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        cell.textLabel?.text = "\(name)\n        Due: \(datetime)"
        return cell
    }
    
    @IBAction func addPressed(_ sender: Any) {
        
        //alert to add a new project
        
        // project name
        
        // date selectors
        
        // initial tasks
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.projectsTableView.reloadData()
    }

}
