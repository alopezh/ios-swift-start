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
    func getTasks() -> AnyPublisher<[Task], DomainError>
    func update(task: Task) -> AnyPublisher<Task, DomainError>
    func save(tasks: [Task]) -> AnyPublisher<[Task], DomainError>
}

class TasksUseCaseImpl: TasksUseCase {
    private let taskService: TaskService

    init(taskService: TaskService) {
        self.taskService = taskService
    }

    func getTasks() -> AnyPublisher<[Task], DomainError> {
		taskService.getTasks()
			.mapError { error -> DomainError in
                .network(error: error)
            }.eraseToAnyPublisher()
    }

    func update(task: Task) -> AnyPublisher<Task, DomainError> {
		taskService.updateTask(id: task.id, task)
            .mapError { error -> DomainError in
                .network(error: error)
            }.eraseToAnyPublisher()
    }

    func save(tasks: [Task]) -> AnyPublisher<[Task], DomainError> {
        let updates = tasks.filter { $0.modified }
            .map { [weak self] in self?.update(task: $0) ?? Empty().eraseToAnyPublisher() }

        let creates = tasks.filter { $0.new }
            .map { [weak self] in self?.create(task: $0) ?? Empty().eraseToAnyPublisher() }

        return Publishers.MergeMany(
            updates + creates
        ).collect().eraseToAnyPublisher()
    }

    func create(task: Task) -> AnyPublisher<Task, DomainError> {
        taskService.createTask(task)
            .mapError { error -> DomainError in
				.network(error: error)
            }.eraseToAnyPublisher()
    }
}
