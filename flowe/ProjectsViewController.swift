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
    var dateField: UITextField!
    let datePicker = UIDatePicker()
    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        projectsTableView.delegate = self
        projectsTableView.dataSource = self
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        getProjects()
    }
    
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
        let dueDate = formatter.string(from: project.due!)
        let name = project.name!
        cell.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        cell.textLabel?.text = "\(name)\n      Due: \(dueDate)"
        return cell
    }
    
    @IBAction func addPressed(_ sender: Any) {
        let alert = UIAlertController(title: "New Project",
                                      message: "Enter the details for your new project",
                                      preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.textFields![0].placeholder = "Project name"
        alert.textFields![1].placeholder = "Date due"
        alert.textFields![2].placeholder = "Enter a description"
        dateField = alert.textFields![1]
        createDatePicker()
        //alertController.view.addSubview(myDatePicker)
        let selectAction = UIAlertAction(title: "Ok",
                                         style: .default,
                                         handler: {
            [self] _ in
            let newProject = Projects(context: self.context)
            newProject.due = self.datePicker.date
            newProject.name = alert.textFields![0].text
            newProject.about = alert.textFields![2].text
            do {
                try self.context.save()
            }catch{
                print("There was an error in saving the Project")
            }
            self.getProjects()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(selectAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    // Swipe to Delete code
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive,
                                        title: "Delete",
                                        handler: { (action, view, completionHandler) in
            let projectToRemove = self.projects![indexPath.row]
            self.context.delete(projectToRemove)
            try! self.context.save()
            self.getProjects()
        })
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    // Date picker function for selecting a date for a new project
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector (donePressed))
        toolbar.setItems([doneBtn], animated: true)
        dateField.inputAccessoryView = toolbar
        dateField.inputView = datePicker
    }
    
    @objc func donePressed() {
        dateField.text = formatter.string(from: datePicker.date)
        self.inputView?.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.projectsTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.projectsTableView.reloadData()
    }

}
