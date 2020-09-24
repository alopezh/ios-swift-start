//
//  Interceptor.swift
//  ios-swift-start
//
//  Created by alopezh on 24/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation

protocol Interceptor {
    func intercept(request: URLRequest)
    func intercetp(response: URLResponse, data: Data)
}

extension Interceptor {
    func intercept(request: URLRequest) {
        // no-op
    }
    
    func intercept(response: URLResponse, data: Data) {
        // no-op
    }
}
