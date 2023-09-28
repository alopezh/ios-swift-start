//
//  ApiRequest.swift
//  concierge-app
//
//  Created by alopezh on 23/09/2022.
//  Copyright © 2022  com.suedtirol All rights reserved.
//

import Foundation
import Combine

protocol DataDecoder {
	
	associatedtype Output: Decodable
	
	func decode(from: Data) throws -> Output
}

class TypedDataDecoder<T: Decodable>: DataDecoder {
	
	typealias Output = T
	
	private let decoder: JSONDecoder
	
	init(decoder: JSONDecoder = JSONDecoder()) {
		self.decoder = decoder
	}
	
	func decode(from: Data) throws -> T {
		try decoder.decode(T.self, from: from)
	}
}

class CombineHttpApiRequest {
	private var interceptors: [Interceptor]

	private let baseUrl: String
	private let decoder: JSONDecoder
	private let encoder: JSONEncoder
	private let errorDecoder: (any DataDecoder)?

	init(baseUrl: String, decoder: JSONDecoder = JSONDecoder(), encoder: JSONEncoder = JSONEncoder(), errorDecoder: (any DataDecoder)? = nil, interceptors: [Interceptor] = []) {
		self.baseUrl = baseUrl
		self.decoder = decoder
		self.encoder = encoder
		self.errorDecoder = errorDecoder
		self.interceptors = interceptors
	}
	
	func get<T: Codable>(id: String, path: String, headers: [String: String]? = nil) -> AnyPublisher<T, Error> {
		performRequest(method: "GET", path: path + "/" + id, body: nil, headers: headers)
	}
	
	func get<T: Codable>(path: String, headers: [String: String]? = nil) -> AnyPublisher<[T], Error> {
		performRequest(method: "GET", path: path, body: nil, headers: headers)
	}

	func getSingle<T: Codable>(path: String, headers: [String: String]? = nil) -> AnyPublisher<T, Error> {
		performRequest(method: "GET", path: path, body: nil, headers: headers)
	}
	
	func post<T: Codable>(path: String, body: Codable, headers: [String: String]? = nil) -> AnyPublisher<T, Error> {
		performRequest(method: "POST", path: path, body: body, headers: headers)
	}
	
	func put<T: Codable>(path: String, id: String, body: Codable, headers: [String: String]? = nil) -> AnyPublisher<T, Error> {
		performRequest(method: "PUT", path: path + "/" + id, body: body, headers: headers)
	}
	
	func delete<T: Codable>(path: String, body: Codable?, headers: [String: String]? = nil) -> AnyPublisher<T, Error> {
		performRequest(method: "DELETE", path: path, body: body, headers: headers)
	}
	
	private func performRequest<T: Codable>(method: String, path: String, body: Codable?, headers: [String: String]? = nil) -> AnyPublisher<T, Error> {
		Deferred<AnyPublisher<T, Error>> { [weak self] in
			
			guard let self = self else {
				return Fail(error: "Invalid State").eraseToAnyPublisher()
			}
			
			let url = self.baseUrl + path

			var request = URLRequest(url: URL(string: url)!)
			request.allHTTPHeaderFields = headers
			request.httpMethod = method

			self.applyRequestInterceptors(&request)

			debugPrint("Performing request. Method: \(method), path: \(url), body: \(String(describing: body))")

			if let body = body {
				do {
					request.httpBody = try self.encoder.encode(body)
				} catch {
					return Fail(error: HttpError<Any>.encodingError(error: error)).eraseToAnyPublisher()
				}
			}

			
			return URLSession.shared.dataTaskPublisher(for: request)
				.tryMap { [weak self] (data: Data, response: URLResponse) in

					guard let response = response as? HTTPURLResponse else {
						throw HttpError.unknown(error: "Error HTTP URL Response", data: try self?.errorDecoder?.decode(from: data))
					}
					
					// 400 -> Error request
					// 401 -> Session Error
					// 500 -> Server error
					switch response.statusCode {
					case 200:
						self?.applyResponseInterceptors(response, data)
						return data
					case 400:
						throw HttpError<Any>.requestError(error: "Request error", data: data)
					case 401:
						throw HttpError<Any>.sessionError(error: "Session error", data: data)
					case 500:
						throw HttpError<Any>.serverError(error: "Server error", data: data)
					default:
						throw HttpError.unknown(error: "Unkown Error", data: try self?.errorDecoder?.decode(from: data))
					}
				}
				.decode(type: T.self, decoder: self.decoder)
				.mapError { error in
					 HttpError<Any>.unknown(error: error)
				}
				.eraseToAnyPublisher()
		}.eraseToAnyPublisher()
	}

	private func applyResponseInterceptors(_ response: URLResponse, _ data: Data) {
		interceptors.forEach { interceptor in
			interceptor.intercept(response: response, data: data)
		}
	}

	private func applyRequestInterceptors(_ request: inout URLRequest) {
		interceptors.forEach { interceptor in
			interceptor.intercept(request: &request)
		}
	}
}
