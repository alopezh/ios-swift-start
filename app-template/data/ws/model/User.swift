//
//  User.swift
//  ios-swift-start
//
//  Created by alopezh on 23/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation

struct User: Codable {
    var email: String
    var password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
