//
//  HomeView.swift
//  ios-swift-start
//
//  Created by alopezh on 30/09/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View { 
        TabView {
            TaskListView()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Task List")
                }.tag(0)
            SettingsView()
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Settings")
                }.tag(1)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
