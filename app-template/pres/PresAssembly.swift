//
//  PresContainer.swift
//  ios-swift-start
//
//  Created by alopezh on 22/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import Swinject

class PresAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(ViewRouter.self) { _ in
            ViewRouter()
        }.inObjectScope(.container)
                
    }
    
}
