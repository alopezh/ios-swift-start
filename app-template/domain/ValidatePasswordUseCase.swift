//
//  ValidatePasswordUseCase.swift
//  ios-swift-start
//
//  Created by alopezh on 23/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation

protocol ValidatePasswordUseCase {
    func isValid(password: String) -> Bool
}

class ValidatePasswordUseCaseImpl: ValidatePasswordUseCase {
    func isValid(password: String) -> Bool {
        false
    }
    
    
}
