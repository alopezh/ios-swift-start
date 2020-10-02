//
//  File.swift
//  ios-swift-start
//
//  Created by alopezh on 23/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import Combine

protocol LoginUseCase {
    func login(user: User) -> AnyPublisher<User,HttpError>
}

class LoginUseCaseImpl: LoginUseCase {
    
    private let userApi: UserApi
    
    private let sessionUseCase: SessionUseCase
    
    init(userApi: UserApi, sessionUseCase: SessionUseCase) {
        self.userApi = userApi
        self.sessionUseCase = sessionUseCase
    }
    
    func login(user: User) -> AnyPublisher<User,HttpError> {
        userApi.login(user: user).map { [weak self] user in
            self?.sessionUseCase.createSession(token: "Token")
            return user
        }.eraseToAnyPublisher()
    }
    
}
