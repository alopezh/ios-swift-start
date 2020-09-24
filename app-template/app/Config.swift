//
//  Config.swift
//  ios-swift-start
//
//  Created by alopezh on 24/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation

enum Endpoits {
    case pre
    case pro
    var api: String {
        switch self {
        case .pre: return "https://virtserver.swaggerhub.com/alopezh/api-start/1.0.0"
        case .pro: return "https://virtserver.swaggerhub.com/alopezh/api-start/1.0.0"
        }
    }
}

struct Config {
    static let endpoints: Endpoits = .pre
}
