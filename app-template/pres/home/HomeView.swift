//
//  HomeView.swift
//  ios-swift-start
//
//  Created by alopezh on 30/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var homeViewModel: HomeViewModel = HomeViewModel()
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View { 
        VStack {
            Text("Hello ")
            Button(action: {self.viewRouter.navigate(to: .login)}) {
                Text("back")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
