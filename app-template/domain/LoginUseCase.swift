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
    func login(user: User) -> AnyPublisher<User, HttpError>
}

class LoginUseCaseImpl: LoginUseCase {
    private let userApi: UserApi

    private let sessionUseCase: SessionUseCase

    init(userApi: UserApi, sessionUseCase: SessionUseCase) {
        self.userApi = userApi
        self.sessionUseCase = sessionUseCase
    }

    //  Avoid catpuring self to improve readability
    //    https://www.swiftbysundell.com/articles/swifts-closure-capturing-mechanics/#weak-references-are-not-always-the-answer
    //    https://www.swiftbysundell.com/articles/combine-self-cancellable-memory-management/
    //    https://stackoverflow.com/questions/67839708/break-swift-closure-retain-circle-with-not-weak-explicit-capture
    // without any capture: LoginUseCase <=> closure
    // with explicit not weak capture:
    //             LoginUseCase
    //              /         \
    //           closure -> sesionUseCase
    // No cycles!

    func login(user: User) -> AnyPublisher<User, HttpError> {
        userApi.login(user: user).map { [sessionUseCase] user in
            sessionUseCase.createSession(token: "Token")
            return user
        }.eraseToAnyPublisher()
    }
}
