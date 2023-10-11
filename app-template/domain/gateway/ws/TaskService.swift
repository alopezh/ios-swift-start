//
//  TaskService.swift
//  ios-swift-start
//
//  Created by alopezh on 10/10/23.
//  Copyright © 2023 com.herranz.all. All rights reserved.
//

import Foundation
import Combine

protocol TaskService {
	func getTasks() -> AnyPublisher<[Task], Error>
	func updateTask(id: UUID, _ task: Task) -> AnyPublisher<Task, Error>
	func createTask(_ task: Task) -> AnyPublisher<Task, Error>
}
