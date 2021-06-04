//
//  Task.swift
//  ios-swift-start
//
//  Created by alopezh on 03/06/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation

struct TaskDM {
    
    var id: UUID
    
    var name: String
    var description: String
    var done: Bool
    
    var modified: Bool
    var new: Bool
    
}

// Initializer added in extension to avoid losing default initializer
extension TaskDM {
    
    init(data: Task) {
        self.init(id: data.id, name: data.name, description: data.description, done: data.done, modified: false, new: false)
    }
    
    func toData() -> Task {
        Task(id: id, name: name, description: description, done: done)
    }

}
