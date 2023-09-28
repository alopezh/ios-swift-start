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
    func getTasks() -> AnyPublisher<[Task], Error>
    func updateTask(id: UUID, _ task: Task) -> AnyPublisher<Task, Error>
    func createTask(_ task: Task) -> AnyPublisher<Task, Error>
}

class TaskApiImpl: CombineHttpApiRequest, TaskApi {
    func getTasks() -> AnyPublisher<[Task], Error> {
        get(path: "/task")
    }

    func updateTask(id: UUID, _ task: Task) -> AnyPublisher<Task, Error> {
        put(path: "/task", id: id.uuidString, body: task)
    }

    func createTask(_ task: Task) -> AnyPublisher<Task, Error> {
        post(path: "/task", body: task)
    }
}
