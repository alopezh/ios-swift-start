//
//  Alert+Extension.swift
//  ios-swift-start
//
//  Created by alopezh on 17/02/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation
import SwiftUI

extension Alert {
    
    init(localizedError: LocalizedError) {
        self = Alert(nsError: localizedError as NSError)
    }
     
    init(nsError: NSError) {
        let message: Text? = {
            let message = [nsError.localizedFailureReason, nsError.localizedRecoverySuggestion].compactMap({ $0 }).joined(separator: "\n\n")
            return message.isEmpty ? nil : Text(message)
        }()
        self = Alert(title: Text(nsError.localizedDescription),
                     message: message,
                     dismissButton: .default(Text("OK")))
    }
}
