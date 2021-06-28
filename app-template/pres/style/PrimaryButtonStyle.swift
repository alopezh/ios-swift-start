//
//  PrimaryButtonStyle.swift
//  ios-swift-start
//
//  Created by alopezh on 30/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    private let isEnabled: Bool

    init(isEnabled: Bool = true) {
        self.isEnabled = isEnabled
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        let color = isEnabled ? LinearGradient(gradient: Gradient(colors: [.primaryColor, .buttonGradientEnd]), startPoint: .bottomLeading, endPoint: .topTrailing) :
            LinearGradient(gradient: Gradient(colors: [.gray, .buttonGradientEnd]), startPoint: .bottomLeading, endPoint: .topTrailing)

        return configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(10)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(5)
        }
}

struct PrimaryButtonViewModifier: ViewModifier {
    @Environment(\.isEnabled) var isEnabled

    func body(content: Content) -> some View {
        return content.buttonStyle(PrimaryButtonStyle(isEnabled: isEnabled))
    }
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("Primary Button")
        }.buttonStyle(PrimaryButtonStyle())
        .padding()
    }
}
