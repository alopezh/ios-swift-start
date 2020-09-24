//
//  LoginView.swift
//  ios-swift-start
//
//  Created by alopezh on 21/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject private(set) var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack() {
            Text("iOS App Template")
            Image("iosapptemplate")
            TextField("Email", text: $loginViewModel.email)
            TextField("Password", text: $loginViewModel.password)
            Button(action: {  self.loginViewModel.submmit() } ) {
                Text("Sign up")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginViewModel: LoginViewModel())
    }
}
