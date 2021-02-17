//
//  ViewError.swift
//  ios-swift-start
//
//  Created by alopezh on 17/02/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation

enum DomainError: LocalizedError {

    case network(error: Error)
    case unexpected(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .network:
            return "Connection Error"
        case .unexpected:
            return "Error"
        }
    }
     
    var failureReason: String? {
        switch self {
        case .network:
            return "Entered password was incorrect"
        case .unexpected:
            return "An error has occurred"
        }
    }
     
    var recoverySuggestion: String? {
        switch self {
        case .network:
            return "Please check network settings"
        case .unexpected:
            return "Please try again"
        }
    }
    
    
}
