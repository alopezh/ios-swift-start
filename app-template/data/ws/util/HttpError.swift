//
//  RequestError.swift
//  concierge-app
//
//  Created by alopezh on 23/09/2022.
//  Copyright © 2022  com.suedtirol All rights reserved.
//

import Foundation

enum HttpError<T>: Error {
	case sessionError(error: Error, data: T? = nil)
	case requestError(error: Error, data: T? = nil)
	case serverError(error: Error, data: T? = nil)
	case encodingError(error: Error)
	case decodingError(error: Error)
	case unknown(error: Error, data: T? = nil)

	init(error: Error, data: T? = nil) {
		if error is DecodingError {
			self = .decodingError(error: error)
		} else if error is EncodingError {
			self = .encodingError(error: error)
		} else {
			self = .unknown(error: error, data: data)
		}
	}
}
