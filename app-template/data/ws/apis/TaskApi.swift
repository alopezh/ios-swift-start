//
//  TaskApi.swift
//  ios-swift-start
//
//  Created by alopezh on 17/02/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation
import Combine

protocol TaskApi {
    func getTasks() -> AnyPublisher<[Task],HttpError>
    func updateTask(id: String, _ task: Task) -> AnyPublisher<Task, HttpError>
}

class TaskApiImpl: HttpApiRequest<Task>, TaskApi {
    
    func getTasks() -> AnyPublisher<[Task], HttpError> {
        get(path: "/task")
    }
    
    func updateTask(id: String, _ task: Task) -> AnyPublisher<Task, HttpError> {
        put(path: "/task", id: id, body: task)
    }
    
}
