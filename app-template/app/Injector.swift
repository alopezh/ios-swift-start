//
//  Injector.swift
//  ios-swift-start
//
//  Created by alopezh on 22/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import Swinject

class Injector  {
    
    static let shared = Injector()
    
    private let assembler = Assembler([PresAssembly(), DomainAssembly(), DataAssembly()])
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return assembler.resolver.resolve(serviceType)
    }
    
}
