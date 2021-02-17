//
//  LoginViewModel.swift
//  ios-swift-start
//
//  Created by alopezh on 21/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import InjectPropertyWrapper

class LoginViewModel : ObservableObject {
    
    private var cancelables = Set<AnyCancellable>()
    
    @Inject
    private var loginUseCase: LoginUseCase
    
    @Inject
    private var viewRouter: ViewRouter
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var loginEnabled = false
    
    init() {
        $email.map { [weak self] email in
            guard let self = self else { return false }
            return self.isDataValid(email, self.password )
        }.assign(to: \.loginEnabled, on: self)
        .store(in: &cancelables)
        
        $password.map { [weak self] password in
            guard let self = self else { return false }
            return self.isDataValid(self.email, password)
        }.assign(to: \.loginEnabled, on: self)
        .store(in: &cancelables)
    }
    
    func submmit() {
        loginUseCase.login(user: User(email: email, password: password))
            .catch({ error -> AnyPublisher<User, Never> in
                debugPrint("Error \(error)")
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            })
        .subscribe(on: DispatchQueue.global())
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: { [weak self] in
            debugPrint("Succes: \($0)")
            self?.viewRouter.navigate(to: .home)
        })
        .store(in: &cancelables)
    }
    
    private func isDataValid(_ email: String, _ password: String) -> Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    
}
