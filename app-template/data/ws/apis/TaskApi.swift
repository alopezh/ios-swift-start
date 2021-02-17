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
}

class TaskApiImpl: HttpApiRequest<Task>, TaskApi {
    
    private let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getTasks() -> AnyPublisher<[Task], HttpError> {
        get(path: baseUrl + "/task")
    }
    
}
