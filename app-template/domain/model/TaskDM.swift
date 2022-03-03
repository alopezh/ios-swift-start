//
//  Task.swift
//  ios-swift-start
//
//  Created by alopezh on 03/06/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation

struct TaskDM {
    var id: UUID

    var name: String
    var description: String
    var done: Bool

    var modified: Bool
    var new: Bool
}
