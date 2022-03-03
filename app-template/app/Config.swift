//
//  Config.swift
//  ios-swift-start
//
//  Created by alopezh on 24/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation

public enum ConfigKey: String {

    case apiUrl

}

struct Config {

    static fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            } else {
                fatalError("Config file not found")
            }
        }
    }
    
    static public func value(key: ConfigKey) -> String {
        return infoDict[key.rawValue] as! String
    }
    
}
