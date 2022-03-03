//
//  Task.swift
//  ios-swift-start
//
//  Created by alopezh on 03/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation

struct Task: Hashable, Codable, Identifiable {
    var id: UUID

    var name: String
    var description: String
    var done: Bool
}
