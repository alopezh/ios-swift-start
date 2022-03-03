//
//  Session.swift
//  ios-swift-start
//
//  Created by alopezh on 30/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation

struct Session {
    let token: String?

    func isLogged() -> Bool {
        token != nil
    }
}
