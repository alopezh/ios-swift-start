//
//  UserApi.swift
//  ios-swift-start
//
//  Created by alopezh on 23/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import Combine

protocol UserApi {
    func login(user: User) -> AnyPublisher<User,HttpError>
}

class UserApiImpl: HttpApiRequest<User>, UserApi {
    
    private let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func login(user: User) -> AnyPublisher<User, HttpError> {
        post(path: baseUrl + "/user/login", body: user)
    }
    
    func addUser(user: User) -> AnyPublisher<User, HttpError> {
        post(path: baseUrl + "/user", body: user)
    }
    
    
}

