//
//  UserServiceImpl.swift
//  ios-swift-start
//
//  Created by alopezh on 11/10/23.
//  Copyright © 2023 com.herranz.all. All rights reserved.
//

import Foundation
import Combine

class UserServiceImpl : UserService {
	
	private let userApi: UserApi
	
	init(userApi: UserApi) {
		self.userApi = userApi
	}
	
	func login(user: User) -> AnyPublisher<User, Error> {
		userApi.login(user: UserMapper.transform(user))
			.map {UserMapper.transform($0) }
			.eraseToAnyPublisher()
	}
	
	
}
