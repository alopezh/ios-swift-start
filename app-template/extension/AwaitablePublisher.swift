//
//  AwaitablePublisher.swift
//  concierge-app
//
//  Created by alopezh on 3/11/22.
//  Copyright © 2022 com.suedtirol. All rights reserved.
//  https://github.com/unsignedapps/CombineAsyncually

import Combine

public protocol AwaitablePublisher: Publisher {
}

public extension AwaitablePublisher where Failure == Error {

	/// Retrieves the result of the publisher as an async function, allowing you to `await` it.
	///
	/// ```swift
	/// let publisher = somePublisher.first()
	/// let result = try await publisher.get()
	/// ```
	///
	/// - Important: If the Publisher never emits your code will stay suspended forever. Be incredibly
	/// careful when using this.
	///
	func get() async throws -> Output {
		let subscriber = Subscribers.Await(upstream: self.eraseToAnyPublisher())

		return try await withTaskCancellationHandler {
			subscriber.cancel()
		} operation: {
			try await withUnsafeThrowingContinuation { continuation in
				subscriber.continue { result in
					continuation.resume(with: result)
				}
			}
		}
	}
}

public extension AwaitablePublisher where Failure == Never {

	/// Retrieves the result of the publisher as an async function, allowing you to `await` it.
	///
	/// ```swift
	/// let publisher = somePublisher.first()
	/// let result = try await publisher.get()
	/// ```
	///
	/// - Important: If the Publisher never emits your code will stay suspended forever. Be incredibly
	/// careful when using this.
	///
	func get() async throws -> Output {
		let subscriber = Subscribers.Await(upstream: self.setFailureType(to: Error.self).eraseToAnyPublisher())

		return try await withTaskCancellationHandler {
			subscriber.cancel()
		} operation: {
			try await withUnsafeThrowingContinuation { continuation in
				subscriber.continue { result in
					continuation.resume(with: result)
				}
			}
		}
	}
}

// MARK: - Supported Publishers
extension Just: AwaitablePublisher {}
extension Result.Publisher: AwaitablePublisher {}
extension AnyPublisher: AwaitablePublisher {}
extension Future: AwaitablePublisher {}
extension Deferred: AwaitablePublisher where DeferredPublisher: AwaitablePublisher {}
extension Publishers.First: AwaitablePublisher {}
extension Publishers.FirstWhere: AwaitablePublisher {}
extension Publishers.TryFirstWhere: AwaitablePublisher {}
extension Fail: AwaitablePublisher {}
