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
                    Text("First")
                }.tag(0)
            SettingsView()
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Second")
                }.tag(1)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
