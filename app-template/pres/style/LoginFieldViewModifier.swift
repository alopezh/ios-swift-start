//
//  LoginFieldViewModifier.swift
//  ios-swift-start
//
//  Created by alopezh on 30/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct LoginFieldViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.gray)
            .background(Color.backgroundGrey)
            .cornerRadius(5)
    }
}

struct LoginFieldViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Field").modifier(LoginFieldViewModifier())
    }
}
