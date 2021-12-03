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

    @IBSegueAction func shoowArchivedProject(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: ProjectsView(project: projects![row]))
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
        animationView = .init(name: "projects")
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1
        animationView?.frame = wrapperView.bounds
        wrapperView.addSubview(animationView!)
        projectsTableView.delegate = self
        projectsTableView.dataSource = self
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        getProjects()
        wrapperView.backgroundColor = view.backgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        return UISwipeActionsConfiguration(actions: [action])
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
