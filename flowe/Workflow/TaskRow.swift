//
//  TaskRow.swift
//  flowe
//
//  Created by Hiran Manoharan on 12/3/21.
//

import SwiftUI

struct TaskRow: View {
  let taskObject: Workflow
  static let releaseFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
  }()

  var body: some View {
    VStack(alignment: .leading) {
      taskObject.title.map(Text.init).font(.title)
      HStack {
        taskObject.task.map(Text.init).font(.caption)
        Spacer()
        taskObject.date.map { Text(Self.releaseFormatter.string(from: $0)) }.font(.caption)
      }
    }
  }
}
