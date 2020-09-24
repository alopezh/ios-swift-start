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
        container.register(ValidatePasswordUseCase.self) { _ in
            ValidatePasswordUseCaseImpl()
        }
        container.register(LoginUseCase.self) { r in
            LoginUseCaseImpl(userApi: r.resolve(UserApi.self)!)
        }
    }
    
}

