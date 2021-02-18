//
//  TaskRowViewModel.swift
//  ios-swift-start
//
//  Created by alopezh on 16/02/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation

class TaskViewModel: ObservableObject, Identifiable, Hashable {
    
    var id: String
    let name: String
    let description: String
    
    @Published var done: Bool = false
    
    init() {
        self.id = "0"
        self.name = ""
        self.description = ""
        self.done = false
    }
    
    init(task: Task) {
        self.name = task.name
        self.done = task.done
        self.description = task.description
        self.id = task.id
    }
    
    static func == (lhs: TaskViewModel, rhs: TaskViewModel) -> Bool {
        lhs.id == rhs.id && lhs.done == rhs.done
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(done)
    }
    
}
