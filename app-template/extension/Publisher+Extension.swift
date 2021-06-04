//
//  Publisher+Extension.swift
//  ios-swift-start
//
//  Created by alopezh on 04/06/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
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
}
