//
//  SessionUseCase.swift
//  ios-swift-start
//
//  Created by alopezh on 30/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import Combine

class SessionUseCase {
    let sessionSubject = CurrentValueSubject<Session?, Never>(nil)

    func createSession(token: String) {
        sessionSubject.send(Session(token: token))
    }

    func closeSession() {
        sessionSubject.send(nil)
    }
}
