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
        
        container.register(LoginViewModel.self) { r in
            let loginVM = LoginViewModel()
            loginVM.loginUseCase = r.resolve(LoginUseCase.self)!
            return loginVM
        }
        
        container.register(LoginView.self) { r in
            LoginView(loginViewModel: r.resolve(LoginViewModel.self)!)
        }
    }
    
}
