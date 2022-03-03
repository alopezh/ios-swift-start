//
//  DataAssembly.swift
//  ios-swift-start
//
//  Created by alopezh on 23/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import Swinject

class DataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UserApi.self) { _ in
            UserApiImpl(baseUrl: Config.endpoints.api)
        }

        container.register(TaskApi.self) { _ in
            TaskApiImpl(baseUrl: Config.endpoints.api)
        }
    }
}
