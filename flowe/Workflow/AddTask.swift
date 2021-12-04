//
//  AddTask.swift
//  flowe
//
//  Created by Hiran Manoharan on 12/3/21.
//

import SwiftUI

struct AddTask: View {
  static let DefaultMovieTitle = "Task"
  static let DefaultMovieGenre = "To-Do Task"

  @State var title = ""
  @State var task = ""
  @State var date = Date()
  let onComplete: (String, String, Date) -> Void

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Title")) {
          TextField("Title name", text: $title)
        }
        Section(header: Text("Task")) {
          TextField("Task description", text: $task)
        }
        Section {
          DatePicker(
            selection: $date,
            displayedComponents: .date) {
              Text("Finish Date").foregroundColor(Color(.gray))
          }
        }
        Section {
          Button(action: addMoveAction) {
            Text("Add Task")
          }
        }
      }
      .navigationBarTitle(Text("Add Task"), displayMode: .inline)
    }
  }

  private func addMoveAction() {
    onComplete(
      title.isEmpty ? AddTask.DefaultMovieTitle : title,
      task.isEmpty ? AddTask.DefaultMovieGenre : task,
      date)
  }
}
