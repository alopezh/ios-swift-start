//
//  Injector.swift
//  ios-swift-start
//
//  Created by alopezh on 22/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import Swinject
import InjectPropertyWrapper

class Injector : InjectPropertyWrapper.Resolver {

    static let shared = Injector()
    
    private let assembler = Assembler([PresAssembly(), DomainAssembly(), DataAssembly()])
    
    init() {
        InjectSettings.resolver = self
    }
    
    func resolve<T>(_ type: T.Type, name: String? = nil) -> T? {
        return assembler.resolver.resolve(type, name: name)
    }
    
}

