//
//  TaskDetailView.swift
//  ios-swift-start
//
//  Created by alopezh on 03/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct TaskDetailView: View {
    
    @ObservedObject var task: TaskViewModel
    
    var body: some View {
        VStack {
            Text(task.name)
            Text(task.description)
            Toggle("", isOn: $task.done )
        }
        
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: TaskViewModel(name: "Task 1", description: "Description"))
    }
}
