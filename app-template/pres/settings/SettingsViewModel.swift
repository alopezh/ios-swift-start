//
//  SettingsViewModel.swift
//  ios-swift-start
//
//  Created by alopezh on 02/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import InjectPropertyWrapper

class SettingsViewModel: ObservableObject {
	
    @Inject
    private var sessionUseCase: SessionUseCase

    func closeSession() {
        sessionUseCase.closeSession()
    }
}
