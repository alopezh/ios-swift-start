//
//  ContentViewModel.swift
//  ios-swift-start
//
//  Created by alopezh on 02/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import InjectPropertyWrapper
import Combine

class ContentViewModel : ObservableObject {
    
    private var cancelables = Set<AnyCancellable>()
    
    @Inject
    private var sessionUseCase: SessionUseCase
    
    @Inject
    private var viewRouter: ViewRouter

    init() {
        sessionUseCase.sessionSubject.sink { [weak self] session in
            if session?.isLogged() ?? false {
                self?.viewRouter.navigate(to: .home)
            } else {
                self?.viewRouter.navigate(to: .login)
            }
        }.store(in: &cancelables)
    }
    
}
