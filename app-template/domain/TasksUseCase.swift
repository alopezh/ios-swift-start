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
    func save(tasks: [TaskDM]) -> AnyPublisher<[TaskDM], DomainError>
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
    
    func save(tasks: [TaskDM]) -> AnyPublisher<[TaskDM], DomainError> {
        let updates = tasks.filter { $0.modified }
            .map { [weak self] in self?.update(task: $0) ?? Empty().eraseToAnyPublisher()}
        
        let creates = tasks.filter { $0.new }
            .map  { [weak self] in self?.create(task: $0) ?? Empty().eraseToAnyPublisher()}
    
        return Publishers.MergeMany(
            updates + creates
        ).collect().eraseToAnyPublisher()
    }
    
    func create(task: TaskDM) -> AnyPublisher<TaskDM, DomainError> {
        taskApi.createTask(task.toData())
            .map { TaskDM(data: $0) }
            .mapError { error -> DomainError in
            .network(error: error)
        }.eraseToAnyPublisher()
    }
     
}
