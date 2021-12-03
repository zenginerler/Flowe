//
//  WorkflowSwiftUIView.swift
//  flowe
//
//  Created by Hiran Manoharan on 12/2/21.
//

import SwiftUI

var myTasks = [dailyTasks(id: 1, date: "date 1", task: "task 1"),
               dailyTasks(id: 2, date: "date 2", task: "task 2"),
               dailyTasks(id: 3, date: "date 3", task: "task 3"),
               dailyTasks(id: 4, date: "date 4", task: "task 4")]

struct ListRow: View {
    var eachTask: dailyTasks
    var body: some View {
        HStack {
            Text(eachTask.date)
            Text(eachTask.task)
        }
    }
}

struct WorkflowSwiftUIView: View {
    var taskToDo: [dailyTasks]
    var body: some View {
        NavigationView {
            List(taskToDo){
                task in ListRow(eachTask: task)
            }
        }.navigationBarTitle(Text("Daily Tasks"))
    }
}

struct WorkflowSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WorkflowSwiftUIView(taskToDo: myTasks)
    }
}

class ChildHostingController: UIHostingController<WorkflowSwiftUIView> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: WorkflowSwiftUIView(taskToDo: myTasks));
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

