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
    func getTasks() -> AnyPublisher<[Task],HttpError>
}

class TasksUseCaseImpl : TasksUseCase {
    
    init() {
        
    }
    
    func getTasks() -> AnyPublisher<[Task],HttpError> {
        Just([Task(id: "1", name:  "Task 1", description: "Description", done: false),
              Task(id: "2", name: "Task 2", description: "Description", done: false)])
            .setFailureType(to: HttpError.self)
            .eraseToAnyPublisher()
    }
    
}
