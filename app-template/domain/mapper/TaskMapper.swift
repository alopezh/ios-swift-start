//
//  TaskMapper.swift
//  ios-swift-start
//
//  Created by alopezh on 22/09/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation

class TaskMapper {
    
    static func from(data: Task) -> TaskDM {
        TaskDM(id: data.id, name: data.name, description: data.description, done: data.done, modified: false, new: false)
    }
    
    static func toData(_ domain: TaskDM) -> Task {
        Task(id: domain.id, name: domain.name, description: domain.description, done: domain.done)
    }

}
