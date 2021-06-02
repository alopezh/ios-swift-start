//
//  AlertViewModel.swift
//  ios-swift-start
//
//  Created by alopezh on 02/06/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation
import SwiftUI

protocol AlertViewModel: AnyObject {
    var error: LocalizedError? { get set }
}

extension AlertViewModel {
    var isPresentingAlert: Binding<Bool> {
        return Binding<Bool>(get: {
            return self.error != nil
        }, set: { newValue in
            guard !newValue else { return }
            self.error = nil
        })
    }
}
