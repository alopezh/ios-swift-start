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
            return NSLocalizedString("Connection Error", comment: "Localized kind: Connection Error")
        case .unexpected:
            return NSLocalizedString("Error", comment: "Localized kind: Error")
        }
    }

    var failureReason: String? {
        switch self {
        case .network:
            return NSLocalizedString("Entered password was incorrect", comment: "Localized kind: Entered password was incorrect")
        case .unexpected:
            return NSLocalizedString("An error has occurred", comment: "Localized kind: An error has occurred")
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .network:
            return NSLocalizedString("Please check network settings", comment: "Localized kind: Please check network settings")
        case .unexpected:
            return NSLocalizedString("Please try again", comment: "Localized kind: Please try again")
        }
    }
}
