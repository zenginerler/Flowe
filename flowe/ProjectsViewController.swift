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
    var textfield: UITextField!
    let datePicker = UIDatePicker()

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
        let alert = UIAlertController(title: "New Project",
                                      message: "Enter the details for your new project",
                                      preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.textFields![0].placeholder = "Project name"
        alert.textFields![1].placeholder = "Date due"
        alert.textFields![2].placeholder = "Enter a description"
        let dateField = alert.textFields![1]
        createDatePicker(textfield: dateField)
        //alertController.view.addSubview(myDatePicker)
        let selectAction = UIAlertAction(title: "Ok",
                                         style: .default,
                                         handler: { _ in
            print("Selected Date: \(self.datePicker.date)")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(selectAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func createDatePicker(textfield: UITextField) {
        datePicker.preferredDatePickerStyle = .wheels
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector (donePressed))
        toolbar.setItems([doneBtn], animated: true)
        textfield.inputAccessoryView = toolbar
        textfield.inputView = datePicker
    }
    
    @objc func donePressed() {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.projectsTableView.reloadData()
    }

}
