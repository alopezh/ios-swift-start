//
//  TaskMapper.swift
//  ios-swift-start
//
//  Created by alopezh on 22/09/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation

class TaskMapper: ModelMapper {
	
	typealias DataModel = TaskWs
	typealias DomainModel = Task
	
	static func transform(_ dataModel: TaskWs) -> Task {
		Task(id: dataModel.id,
			 name: dataModel.name,
			 description: dataModel.description,
			 done: dataModel.done,
			 modified: false,
			 new: true)
	}
	
	static func transform(_ domainModel: Task) -> TaskWs {
		TaskWs(id: domainModel.id,
			   name: domainModel.name,
			   description: domainModel.description,
			   done: domainModel.done)
	}


}
