//
//  UserMapper.swift
//  ios-swift-start
//
//  Created by alopezh on 11/10/23.
//  Copyright © 2023 com.herranz.all. All rights reserved.
//

import Foundation

class UserMapper : ModelMapper {

	
	typealias DataModel = UserWs
	
	typealias DomainModel = User
	
	static func transform(_ dataModel: UserWs) -> User {
		User(email: dataModel.email, password: dataModel.password)
	}
	
	static func transform(_ domainModel: User) -> UserWs {
		UserWs(email: domainModel.email, password: domainModel.password)
	}
	
	
}
