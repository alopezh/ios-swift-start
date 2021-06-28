//
//  Example.swift
//  ios-swift-start
//
//  Created by alopezh on 06/02/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


class Model: ObservableObject {
    private var cancelables = Set<AnyCancellable>()

    private var id = 0

    @Published var tasks: [TaskViewModel2] = []

    @Published var filterDone = false

    init() {
        addMore()
    }

    func filter() -> [TaskViewModel2] {
        filterDone ? tasks.filter { !$0.done } : tasks
    }

    func addMore() {
        [
         TaskViewModel2(name: "Task \(id)", description: "Description"),
         TaskViewModel2(name: "Task \(id + 1)", description: "Description")
        ].forEach { add(task: $0) }
        id += 2
    }

    private func add(task: TaskViewModel2) {
        tasks.append(task)
        task.objectWillChange
            .sink { self.objectWillChange.send() }
            .store(in: &cancelables)
    }
}

class TaskViewModel2: ObservableObject, Identifiable, Hashable {
  var id: String { name }
  let name, description: String

  @Published var done = false

  init(name: String, description: String) {
    self.name = name
    self.description = description
  }

  static func == (lhs: TaskViewModel2, rhs: TaskViewModel2) -> Bool {
    lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

struct TaskListView2: View {
  @EnvironmentObject var model: Model

  var body: some View {
    NavigationView {
      VStack {
        Toggle(isOn: $model.filterDone) {
          Text("Undone only")
        }.padding()
        List {
            ForEach(model.filter(), id: \.self) { task in
            TaskRow2(task: task)
            }
        }
        Button("Add More") {
            model.addMore()
        }
      }.navigationBarTitle(Text("Tasks"))
    }
  }
}

struct TaskRow2: View {
  @ObservedObject var task: TaskViewModel2
    var body: some View {
        HStack {
            Text(task.name)
            Spacer()
          Toggle("", isOn: $task.done).labelsHidden()
        }
    }
}
