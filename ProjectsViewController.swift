//
//  ProjectsViewController.swift
//  Flowe
//
//  Created by Michael Walters on 11/2/21.
//

import UIKit
import Foundation
import CoreData
import SwiftUI

class ProjectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBSegueAction func showProject(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: ProjectsView(project: projects![row]))
    }
    
    @IBOutlet weak var projectsTableView: UITableView!
    @IBOutlet weak var addProjectButton: UIBarButtonItem!
    
    var projects: [Projects]?
    
    var row = 0
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
        let cell = projectsTableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        let project = self.projects![indexPath.row]
        let dueDate = formatter.string(from: project.due!)
        let name = project.name!
        cell.textLabel?.font = UIFont(name:"Sinhala Sangam MN", size: 20.0)
        cell.textLabel?.text = "\(name)\nDue: \(dueDate)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        row = indexPath.row
        return indexPath
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
    
    // Swipe left to Delete code
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive,
                                        title: "Delete",
                                        handler: { (action, view, completionHandler) in
            let projectToRemove = self.projects![indexPath.row]
            
            // alert to confirm the delete action
            let alert = UIAlertController(title: "Remove \(projectToRemove.name ?? "")",
                                              message: "Are you sure you want to remove this project? This action is irreversible.",
                                              preferredStyle: .alert)
                
                let selectAction = UIAlertAction(title: "Delete",
                                                 style: .destructive,
                                                 handler: {
                                                    [self] _ in
                                                    self.context.delete(projectToRemove)
                                                    do {
                                                        try self.context.save()
                                                    }catch{
                                                        print("There was an error in removing the Project")
                                                    }
                                                    self.getProjects()
                })
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                    [self] _ in self.projectsTableView.reloadData()})
                alert.addAction(selectAction)
                alert.addAction(cancelAction)
            self.present(alert, animated: true)
        })
        action.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    // swipe right to edit
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal,
                                        title: "Edit",
                                        handler: { (action, view, completionHandler) in
            
            let projectToEdit = self.projects![indexPath.row]
            
            // alert to edit the project info
            let alert = UIAlertController(title: "Editing \(projectToEdit.name ?? "")",
                                          message: "Make desired changes to the project.",
                                          preferredStyle: .alert)
            alert.addTextField()
            alert.addTextField()
            alert.addTextField()
            alert.textFields![0].text = projectToEdit.name
            alert.textFields![1].text = "\(self.formatter.string(from: projectToEdit.due!))"
            alert.textFields![2].text = projectToEdit.about
            self.dateField = alert.textFields![1]
            self.createDatePicker()
            let selectAction = UIAlertAction(title: "Confirm",
                                             style: .default,
                                             handler: {
                [self] _ in
                projectToEdit.due = self.datePicker.date
                projectToEdit.name = alert.textFields![0].text
                projectToEdit.about = alert.textFields![2].text
                do {
                    try self.context.save()
                }catch{
                    print("There was an error in saving the Project")
                }
                self.getProjects()
            })
        
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                [self] _ in self.projectsTableView.reloadData()})
            alert.addAction(selectAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        })
        action.image = UIImage(systemName: "pencil")
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