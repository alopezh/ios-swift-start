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
    func login(user: User) -> AnyPublisher<User, Error>
}

class UserApiImpl: CombineHttpApiRequest, UserApi {
    func login(user: User) -> AnyPublisher<User, Error> {
        post(path: "/user/login", body: user)
    }
}
