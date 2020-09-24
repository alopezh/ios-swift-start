//
//  LoginViewModel.swift
//  ios-swift-start
//
//  Created by alopezh on 21/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import Combine

class LoginViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    var loginUseCase: LoginUseCase!
    
    private var cancelables = Set<AnyCancellable>()
    
    func submmit() {
        loginUseCase.login(user: User(email: email, password: password))
            .catch({ error -> AnyPublisher<User, Never> in
                debugPrint("Error \(error)")
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            })
        .subscribe(on: DispatchQueue.global())
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: { debugPrint("Succes: \($0)") })
        .store(in: &cancelables)
    }
    
}
