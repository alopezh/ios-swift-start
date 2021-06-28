//
//  SettingsView.swift
//  ios-swift-start
//
//  Created by alopezh on 02/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject private var settingsViewModel = SettingsViewModel()

    var body: some View {
        VStack {
            Button(action: { self.settingsViewModel.closeSession() }) {
                Text("Close Session")
            }.modifier(PrimaryButtonViewModifier())
        }.padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
