//
//  TaskServiceImpl.swift
//  ios-swift-start
//
//  Created by alopezh on 10/10/23.
//  Copyright © 2023 com.herranz.all. All rights reserved.
//

import Foundation
import Combine

class TaskServiceImpl : TaskService {
	
	private let taskApi : TaskApi
	
	init(taskApi: TaskApi) {
		self.taskApi = taskApi
	}
	
	func getTasks() -> AnyPublisher<[Task], Error> {
		taskApi.getTasks().map { TaskMapper.listTransformModel($0)}.eraseToAnyPublisher()
	}
	
	func updateTask(id: UUID, _ task: Task) -> AnyPublisher<Task, Error> {
		taskApi.updateTask(id: id, TaskMapper.transform(task)).map { TaskMapper.transform($0)}.eraseToAnyPublisher()
	}
	
	func createTask(_ task: Task) -> AnyPublisher<Task, Error> {
		taskApi.createTask(TaskMapper.transform(task)).map { TaskMapper.transform($0)}.eraseToAnyPublisher()
	}
	
	
}
