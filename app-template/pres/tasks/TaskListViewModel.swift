//
//  TaskListViewModel.swift
//  ios-swift-start
//
//  Created by alopezh on 03/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import Combine

class TaskListViewModel : ObservableObject  {
    
    private var cancelables = Set<AnyCancellable>()
    
    @Published var filterDone = false

    @Published var tasks: [TaskViewModel] = []
    
    func filter() -> [TaskViewModel]  {
        filterDone ? tasks.filter { !$0.done } : tasks
    }
    
    func fetchTasks() {
        let id = 0
        [
         TaskViewModel(name: "Task \(id)", description: "Description"),
         TaskViewModel(name: "Task \(id + 1)", description: "Description")
        ].forEach { add(task: $0) }
    }
    
    private func add(task: TaskViewModel) {
        tasks.append(task)
        task.objectWillChange
            .sink { self.objectWillChange.send() }
            .store(in: &cancelables)

    }
    
}
