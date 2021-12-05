//
//  WorkflowSwiftUIView.swift
//  flowe
//
//  Created by Hiran Manoharan on 12/2/21.
//

import SwiftUI
import CoreData
import WebKit

struct WorkflowSwiftUIView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Workflow.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Workflow.date, ascending: true)],
        predicate: NSPredicate(format: "name MATCHES '\(Variables.username)'")
    ) var tasksList: FetchedResults<Workflow>
    
     
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
        self.managedObjectContext.delete(toDo)
      }
      saveContext()
    }

    func addTask(title: String, task: String, date: Date) {
        
        let newTask = WorkflowTasks(context: managedObjectContext)
        newTask.title = title
        newTask.task = task
        newTask.date = date
        newTask.name = Variables.username
        saveContext()
    }

    func saveContext() {
      do {
        try managedObjectContext.save()
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }
}

struct WorkflowSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WorkflowSwiftUIView()
    }
}

class ChildHostingController: UIHostingController<WorkflowSwiftUIView> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: WorkflowSwiftUIView());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


