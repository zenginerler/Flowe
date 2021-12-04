//
//  ProjectArchiveVC.swift
//  flowe
//
//  Created by Michael Walters on 12/3/21.
//

import UIKit
import Foundation
import CoreData
import SwiftUI
import Lottie

class ProjectArchiveVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBSegueAction func showArchivedProject(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: ArchiveView(project: projects![row]))
    }
    
    @IBOutlet weak var projectsTableView: UITableView!
    @IBOutlet weak var wrapperView: UIView!
    
    var projects: [Projects]?
    var row = 0
    let userCalendar = Calendar(identifier: .gregorian)
    let formatter = DateFormatter()
    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    
    var animationView: AnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Lottie Animation Settings
        animationView = .init(name: "archive")
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1
        animationView?.frame = wrapperView.bounds
        wrapperView.addSubview(animationView!)
        projectsTableView.delegate = self
        projectsTableView.dataSource = self
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        view.backgroundColor = UIColor.init(named: "custom_logo_blues")
        projectsTableView.backgroundColor = UIColor.init(named: "custom_logo_light_blues")
        projectsTableView.layer.cornerRadius = 8
        wrapperView.backgroundColor = view.backgroundColor
        getProjects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Variables.deleteProject {
            self.context.delete(projects![row])
            try self.context.save()
            Variables.deleteProject = false
        }
        getProjects()

        self.projectsTableView.reloadData()
        darkModeCheck()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.projectsTableView.reloadData()
        animationView?.play()
    }
    
    func getProjects() {
        do{
            let request = Projects.fetchRequest() as NSFetchRequest<Projects>
            let owner = NSPredicate(format: "owner == %@", Variables.username)
            let finished = NSPredicate(format: "finished == %d", true)
            let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [owner,finished])
            request.predicate = compound
            try self.projects = self.context.fetch(request)
        }
        catch{
            
        }
        //Update UI in queue
        DispatchQueue.main.async {
            self.projectsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectsTableView.dequeueReusableCell(withIdentifier: "archiveCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        let project = self.projects![indexPath.row]
        let dueDate = formatter.string(from: project.due!)
        let name = project.name!
        cell.layer.cornerRadius = 8
        cell.backgroundColor = UIColor.init(named: "custom_logo_light_blues")
        cell.textLabel?.font = UIFont(name:"Sinhala Sangam MN", size: 20.0)
        cell.textLabel?.text = "\(name)\nDue: \(dueDate)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        row = indexPath.row
        return indexPath
    }
    
    // Swipe left to Delete code
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive,
                                        title: "Delete",
                                        handler: { (action, view, completionHandler) in
            let projectToRemove = self.projects![indexPath.row]
            
            // alert to confirm the delete action
            let alert = UIAlertController(title: "Remove \(projectToRemove.name ?? "")",
                                              message: "Are you sure you want to permanantly delete this project? This action is irreversible.",
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
        action.backgroundColor = UIColor.init(named: "custom_red")
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    // swipe right to restore to main projects
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Edit",
                                        handler: { (action, view, completionHandler) in
            
            let projectToEdit = self.projects![indexPath.row]
            
            // alert to confirm restoration
            let alert = UIAlertController(title: "Restore \(projectToEdit.name ?? "")?",
                                          message: "Do you want to restore \(projectToEdit.name ?? "") to active projects?",
                                          preferredStyle: .alert)
            let selectAction = UIAlertAction(title: "Confirm",
                                             style: .default,
                                             handler: {
                [self] _ in
                projectToEdit.finished = false
                do {
                    try self.context.save()
                }catch{
                    print("There was an error in saving the Project")
                }
                self.projects?.remove(at: row)
                self.getProjects()
            })
        
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                [self] _ in self.projectsTableView.reloadData()})
            alert.addAction(selectAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        })
        action.image = UIImage(systemName: "arrowshape.turn.up.left.fill")
        action.backgroundColor = UIColor.init(named: "custom_green")
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    // trash button to remove all projects permanantly
    @IBAction func removeAllProjects(_ sender: Any) {
            // alert to delete all of the project info
            let alert = UIAlertController(title: "WARNING",
                                          message: "This action will remove ALL archived projects. Press DELETE ALL to continue.",
                                          preferredStyle: .alert)
            let selectAction = UIAlertAction(title: "DELETE ALL",
                                             style: .destructive,
                                             handler: {
                [self] _ in
//                let deleteRequest = NSBatchDeleteRequest(fetchRequest: Projects.fetchRequest())
                do {
                    for projectToDelete in projects! {
                        self.context.delete(projectToDelete)
                    }
                    try context.save()
                        
                } catch {
                }
                self.getProjects()
            })
        
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                [self] _ in self.projectsTableView.reloadData()})
            alert.addAction(selectAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
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
