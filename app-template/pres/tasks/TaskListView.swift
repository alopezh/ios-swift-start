//
//  TaskListView.swift
//  ios-swift-start
//
//  Created by alopezh on 03/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject private var viewModel = TaskListViewModel()

    var body: some View {
        
        NavigationView {
            VStack {
                Toggle(isOn: $viewModel.filterDone) {
                    Text("Filter done")
                }.padding()
                List {
                    ForEach(viewModel.filter(), id: \.self) { task in
                        NavigationLink(destination: TaskDetailView(task: task)) {
                            TaskRow(task: task)
                        }
                    }
                }
            }.navigationBarTitle(Text("Tasks"))
        }.onAppear {
            viewModel.fetchTasks()
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
