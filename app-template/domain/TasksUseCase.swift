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
    func getTasks() -> AnyPublisher<[Task],DomainError>
}

class TasksUseCaseImpl : TasksUseCase {
    
    private let taskApi: TaskApi
    
    init(taskApi: TaskApi) {
        self.taskApi = taskApi
    }
    
    func getTasks() -> AnyPublisher<[Task],DomainError> {
        taskApi.getTasks().mapError { error -> DomainError in
            .network(error: error)
        }.eraseToAnyPublisher()
    }
    
}
