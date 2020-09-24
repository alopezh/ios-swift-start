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
    
    init(userApi: UserApi) {
        self.userApi = userApi
    }
    
    func login(user: User) -> AnyPublisher<User,HttpError> {
        userApi.login(user: user)
    }
    
}
