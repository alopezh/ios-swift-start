//
//  ContentView.swift
//  ios-swift-start
//
//  Created by alopezh on 30/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var viewRouter: ViewRouter
    
    @ObservedObject private var contentViewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            if viewRouter.currentPage == ViewRouter.Page.login.rawValue {
               // LoginView().transition(.offset(y: 500))
                HomeView()
            } else if viewRouter.currentPage == ViewRouter.Page.home.rawValue {
                HomeView()
            } else if viewRouter.currentPage == ViewRouter.Page.taskList.rawValue {
                TaskListView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
