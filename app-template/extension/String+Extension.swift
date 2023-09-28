//
//  String+Extension.swift
//  concierge-app
//
//  Created by alopezh on 3/11/22.
//  Copyright © 2022 com.suedtirol. All rights reserved.
//

import Foundation

extension String: LocalizedError {
	public var errorDescription: String? { return self }
	
	func firstCapitalLetter() -> String {
		return prefix(1).capitalized + dropFirst()
	}	
}
