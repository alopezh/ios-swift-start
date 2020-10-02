//
//  HomeViewModel.swift
//  ios-swift-start
//
//  Created by alopezh on 01/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation

class HomeViewModel: ObservableObject {
    var name = "HomeViewModel"
    init() {
        print("HomeViewModel init")
    }
    deinit {
        print("HomeViewModel deinit")
    }
}
