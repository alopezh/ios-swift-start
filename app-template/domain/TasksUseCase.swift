//
//  TasksUseCase.swift
//  ios-swift-start
//
//  Created by alopezh on 16/02/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation
import Combine

protocol TasksUseCase {
    func getTasks() -> AnyPublisher<[TaskDM],DomainError>
    func update(task: TaskDM) -> AnyPublisher<TaskDM,DomainError>
}

class TasksUseCaseImpl : TasksUseCase {
    
    private let taskApi: TaskApi
    
    init(taskApi: TaskApi) {
        self.taskApi = taskApi
    }
    
    func getTasks() -> AnyPublisher<[TaskDM],DomainError> {
        taskApi.getTasks()
            .map { tasks in
                tasks.map { TaskDM(data: $0) }
            }.mapError { error -> DomainError in
                .network(error: error)
            }.eraseToAnyPublisher()
    }
    
    func update(task: TaskDM) -> AnyPublisher<TaskDM,DomainError> {
        taskApi.updateTask(id: task.id, task.toData())
            .map { TaskDM(data: $0) }
            .mapError { error -> DomainError in
                .network(error: error)
            }.eraseToAnyPublisher()
    }
    
}
