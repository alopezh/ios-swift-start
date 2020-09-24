//
//  ApiRequest.swift
//  ios-swift-start
//
//  Created by alopezh on 23/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import Combine

class HttpApiRequest<Element: Codable> {
    
    public private(set) var interceptors: [Interceptor] = []
    
    var errorHandler: ErrorHandler?
    
    func get(path: String, headers: [String:String]? = nil) -> AnyPublisher<Element, HttpError> {
        perfromRequest(method: "GET", path: path, body: nil, headers: headers)
    }
    
    func post(path: String, body: Element, headers: [String:String]? = nil) -> AnyPublisher<Element, HttpError> {
       perfromRequest(method: "POST", path: path, body: body, headers: headers)
    }
    
    func put(path: String, body: Element, headers: [String:String]? = nil) -> AnyPublisher<Element, HttpError> {
        perfromRequest(method: "PUT", path: path, body: body, headers: headers)
    }
    
    func delete(path: String, body: Element?, headers: [String:String]? = nil) -> AnyPublisher<Element, HttpError> {
        perfromRequest(method: "DELETE", path: path, body: body, headers: headers)
    }
    
    private func perfromRequest(method: String, path: String, body: Element?, headers: [String:String]? = nil) -> AnyPublisher<Element, HttpError> {
        Deferred<AnyPublisher<Element, HttpError>> { [weak self] in
            
            var request = URLRequest(url: URL(string: path)!)
            request.allHTTPHeaderFields = headers
            request.httpMethod = method
            
            self?.applyRequestInterceptors(request)
            
            if let body = body {
                do {
                    request.httpBody = try JSONEncoder().encode(body)
                } catch {
                    return Fail(error: .encodingError(error: error)).eraseToAnyPublisher()
                }
            }
            
            self?.applyRequestInterceptors(request)
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map { [weak self] output in
                self?.applyResponseInterceptors(output.response, output.data)
                return output.data
            }
            .decode(type: Element.self, decoder: JSONDecoder())
            .mapError { [weak self] error in
                self?.errorHandler?.handle(error: error)
                return HttpError(error: error)
            }
            .eraseToAnyPublisher()
            
        }.eraseToAnyPublisher()
    }
    
    private func applyResponseInterceptors(_ response: URLResponse, _ data: Data) {
        interceptors.forEach { interceptor in
            interceptor.intercept(response: response, data: data)
        }
    }
    
    private func applyRequestInterceptors(_ request: URLRequest) {
        interceptors.forEach { interceptor in
            interceptor.intercept(request: request)
        }
    }
}
