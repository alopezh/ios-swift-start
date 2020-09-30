//
//  PrimaryButtonStyle.swift
//  ios-swift-start
//
//  Created by alopezh on 30/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(10)
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [.primaryColor, .buttonGradientEnd]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .cornerRadius(5)
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
