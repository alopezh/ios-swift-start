//
//  LoginView.swift
//  ios-swift-start
//
//  Created by alopezh on 21/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject private var loginViewModel = LoginViewModel()
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack() {
            
            Text("iOS App Template")
            Text("Log Into Your Account")
                .font(.title)
                .padding(.bottom, 30)
        
            
            TextField("Email", text: $loginViewModel.email)
                .modifier(LoginFieldViewModifier())
                .textContentType(.emailAddress)
                
            SecureField("Password", text: $loginViewModel.password)
                .modifier(LoginFieldViewModifier())
                .textContentType(.password)
            
            Button(action: {
                self.loginViewModel.submmit()
            }) {
                Text("Log In")
            }
            .modifier(PrimaryButtonViewModifier())
            .disabled(!loginViewModel.loginEnabled)
            
        }.padding()
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
