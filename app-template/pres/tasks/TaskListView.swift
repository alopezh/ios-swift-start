//
//  TaskListView.swift
//  ios-swift-start
//
//  Created by alopezh on 03/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject private var taskListViewModel = TaskListViewModel()
        
    var body: some View {
        NavigationView {
            VStack {
                Toggle(isOn: $taskListViewModel.showNotDoneOnly) {
                    Text("Undone only")
                }.padding()
                List(taskListViewModel.tasks.indices, id: \.self) { idx in
                    if !self.taskListViewModel.showNotDoneOnly || !self.taskListViewModel.tasks[idx].done {
                        NavigationLink(destination: TaskDetailView(task: self.taskListViewModel.tasks[idx])) {
                            TaskRow(task: self.$taskListViewModel.tasks[idx])
                        }
                    }
                }
            }.navigationBarTitle(Text("Tasks"))
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
