//
//  DomainAssembly.swift
//  ios-swift-start
//
//  Created by alopezh on 23/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import Swinject

class DomainAssembly : Assembly {
    func assemble(container: Container) {
        
        container.register(LoginUseCase.self) { r in
            LoginUseCaseImpl(userApi: r.resolve(UserApi.self)!,
                             sessionUseCase: r.resolve(SessionUseCase.self)!)
        }.inObjectScope(.container)
        
        container.register(SessionUseCase.self) { r in
            SessionUseCase()
        }.inObjectScope(.container)
        
        container.register(TasksUseCase.self) { r in
            TasksUseCaseImpl()
        }.inObjectScope(.container)
        
    }
    
}

