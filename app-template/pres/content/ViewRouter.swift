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

    let objectWillChange = PassthroughSubject<ViewRouter, Never>()

    private(set) var currentPage: String = "" {
        didSet {
            withAnimation {
                objectWillChange.send(self)
            }
        }
    }

    func navigate(to: Page) {
        currentPage = to.rawValue
    }

    enum Page: String {
        case home
        case login
        case taskList
    }
}
