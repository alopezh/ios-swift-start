//
//  Publisher+Extension.swift
//  concierge-app
//
//  Created by alopezh on 04/06/2022.
//  Copyright © 2022 com.suedtirol. All rights reserved.
//

//https://www.swiftbysundell.com/articles/combine-self-cancellable-memory-management/

import Foundation
import Combine

extension Publisher where Failure == Never {
	func weakAssign<T: AnyObject>(
		to keyPath: ReferenceWritableKeyPath<T, Output>,
		on object: T
	) -> AnyCancellable {
		sink { [weak object] value in
			object?[keyPath: keyPath] = value
		}
	}
	
	func weakAssign<T: AnyObject>(
		completion handler: @escaping ((Subscribers.Completion<Self.Failure>) -> Void),
		to keyPath: ReferenceWritableKeyPath<T, Output>,
		on object: T
	) -> AnyCancellable {
		sink { receiveCompletion in
			handler(receiveCompletion)
		} receiveValue: { [weak object] value in
			object?[keyPath: keyPath] = value
		}
	}
	
	func finally(handler: @escaping () -> Void) -> Publishers.HandleEvents<Self> {
		handleEvents( receiveCompletion: { _ in handler() }, receiveCancel: { handler() })
	}
}
