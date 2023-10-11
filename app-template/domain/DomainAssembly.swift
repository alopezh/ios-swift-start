//
//  DomainAssembly.swift
//  ios-swift-start
//
//  Created by alopezh on 23/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import Swinject

class DomainAssembly: Assembly {
    func assemble(container: Container) {
		
        container.register(LoginUseCase.self) { res in
			LoginUseCaseImpl(userService: res.resolve(UserService.self)!,
                             sessionUseCase: res.resolve(SessionUseCase.self)!)
        }.inObjectScope(.container)

        container.register(SessionUseCase.self) { _ in
            SessionUseCase()
        }.inObjectScope(.container)

        container.register(TasksUseCase.self) { res in
            TasksUseCaseImpl(taskService: res.resolve(TaskService.self)!)
        }.inObjectScope(.container)
    }
}
