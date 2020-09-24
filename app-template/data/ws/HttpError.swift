//
//  RequestError.swift
//  ios-swift-start
//
//  Created by alopezh on 23/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation

enum HttpError: Error {
    case sessionError(error: Error)
    case requestError(error: Error)
    case serverError(error: Error)
    case encodingError(error: Error)
    case decodingError(error: Error)
    case unknown(error: Error)
    
    init(error: Error) {
        if error is DecodingError {
            self = .decodingError(error: error)
        } else {
            self = .unknown(error: error)
        }
    }
}
