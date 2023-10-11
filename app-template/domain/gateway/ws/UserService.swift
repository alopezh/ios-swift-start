//
//  UserService.swift
//  ios-swift-start
//
//  Created by alopezh on 10/10/23.
//  Copyright © 2023 com.herranz.all. All rights reserved.
//

import Foundation
import Combine

protocol UserService {
	func login(user: User) -> AnyPublisher<User, Error>
}
