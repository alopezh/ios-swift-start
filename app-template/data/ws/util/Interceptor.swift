//
//  Interceptor.swift
//  concierge-app
//
//  Created by alopezh on 24/09/2022.
//  Copyright © 2022  com.suedtirol All rights reserved.
//

import Foundation

protocol Interceptor {
	func intercept(request: inout URLRequest)
	func intercept(response: URLResponse, data: Data)
}
// Default implementations
extension Interceptor {
	func intercept(request: URLRequest) {}
	func intercept(response: URLResponse, data: Data) {}
}
