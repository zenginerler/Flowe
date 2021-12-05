//
//  WorkflowVC.swift
//  flowe
//
//  Created by Mehmet Yavuz Zenginerler on 12/1/21.
//

import UIKit
import SwiftUI

class WorkflowVC: UIViewController {

    let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    let viewHC = UIHostingController(rootView: SwiftUIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addChild(viewHC)
//        viewHC.view.frame = view.bounds
//        view.addSubview(viewHC.view)
        
        assignbackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        darkModeCheck()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let swiftUIView = UIHostingController(rootView: SwiftUIView().environment(\.managedObjectContext, moc!))
//        swiftUIView.modalPresentationStyle = .fullScreen
        present(swiftUIView, animated: true, completion: nil)
    }

    struct SwiftUIView: View {
        @Environment(\.managedObjectContext) var moc

        @FetchRequest(
            entity: WorkflowTasks.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \WorkflowTasks.date, ascending: true)],
            predicate: NSPredicate(format: "name MATCHES '\(Variables.username)'")
        ) var tasksList: FetchedResults<WorkflowTasks>
        
         
        @State var isPresented = false
        
        var body: some View {
          NavigationView {
            List {
              ForEach(tasksList, id: \.title) {
                TaskRow(taskObject: $0)
              }
              .onDelete(perform: deleteTask)
            }
            .sheet(isPresented: $isPresented) {
              AddTask { title, task, date in
                self.addTask(title: title, task: task, date: date)
                self.isPresented = false
              }
            }
            .navigationBarTitle(Text("Daily Tasks"))
            .navigationBarItems(trailing:
              Button(action: { self.isPresented.toggle() }) {
                Image(systemName: "plus")
              }
            )
          }
        }

        func deleteTask(at offsets: IndexSet) {
          offsets.forEach { index in
            let toDo = self.tasksList[index]
            self.moc.delete(toDo)
          }
          saveContext()
        }

        func addTask(title: String, task: String, date: Date) {
            
            let newTask = WorkflowTasks(context: moc)
            newTask.title = title
            newTask.task = task
            newTask.date = date
            newTask.name = Variables.username
            saveContext()
        }

        func saveContext() {
          do {
            try moc.save()
          } catch {
            print("Error saving managed object context: \(error)")
          }
        }
    }
    
    func assignbackground() {
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
            (view.subviews[0] as! UIImageView).image = UIImage(named: "sharp_light")
        } else if (Variables.appTheme == 2) {
            overrideUserInterfaceStyle = .dark
            (view.subviews[0] as! UIImageView).image = UIImage(named: "sharp_dark")
        } else {
            print("\nTheme ERROR")
        }
    }
}
