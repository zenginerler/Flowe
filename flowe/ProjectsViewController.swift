//
//  ProjectsViewController.swift
//  Flowe
//
//  Created by Michael Walters on 11/2/21.
//

import UIKit
import Foundation
import CoreData

//Project class will use Person class
class Project {
    //var initiator: Person?
    //var team: [Person] = []
    //var tasks: [Tasks] = []
    var name: String
    var due = DateComponents()
    var description: String

    init(){
        // creator = Person
        description = ""
        name = ""
    }
}

protocol addProject {
    func addProject(project: Project)
}

var projectList: [Project] = []

class ProjectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var projectsTableView: UITableView!
    // test vars
    let project1 = Project()
    let project2 = Project()
    let project3 = Project()
    
    let userCalendar = Calendar(identifier: .gregorian)
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        projectsTableView.dataSource = self
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        
        self.project1.name = "Project 1"
        project1.due.month = 7
        project1.due.year = 2021
        project1.due.day = 11
        
        self.project2.name = "Project 2"
        project2.due.month = 8
        project2.due.year = 2021
        project2.due.day = 1
        
        self.project3.name = "Project 3"
        project3.due.month = 10
        project3.due.year = 2021
        project3.due.day = 15
        
        addProject(project: project1)
        addProject(project: project2)
        addProject(project: project3)
    }
    
    func addProject (project: Project) {
        projectList.append(project)
        self.projectsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        let project = projectList[indexPath.row]
        let dateDue = userCalendar.date(from: project.due)
        let name = project.name
        let datetime = formatter.string(from: dateDue!)
        print(dateDue!)
        cell.textLabel?.text = "\(name)\n           Due: \(datetime)"
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.projectsTableView.reloadData()
    }

}

