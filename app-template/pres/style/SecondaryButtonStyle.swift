//
//  SecondaryButtonStyle.swift
//  ios-swift-start
//
//  Created by alopezh on 02/06/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    
    private let isEnabled: Bool
    
    init(isEnabled: Bool = true) {
        self.isEnabled = isEnabled
    }
 
    func makeBody(configuration: Self.Configuration) -> some View {
    
        return configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(10)
            .border(Color.primaryColor, width: 1)
            .foregroundColor(.primaryColor)
            .background(Color.white)
            .cornerRadius(5)
        }
}

struct SecondaryButtonViewModifier: ViewModifier {
    @Environment(\.isEnabled) var isEnabled
    
    func body(content: Content) -> some View {
        return content.buttonStyle(SecondaryButtonStyle(isEnabled: isEnabled))
    }
}

struct SecondaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("Secondary Button")
        }.buttonStyle(PrimaryButtonStyle())
        .padding()
    }
}
