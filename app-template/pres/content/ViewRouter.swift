//
//  ViewRouter.swift
//  ios-swift-start
//
//  Created by alopezh on 01/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation

import Combine
import SwiftUI

class ViewRouter: ObservableObject {

    let objectWillChange = PassthroughSubject<ViewRouter,Never>()

    var currentPage: String = "login" {
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
    
}
