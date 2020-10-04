//
//  TaskDetailView.swift
//  ios-swift-start
//
//  Created by alopezh on 03/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct TaskDetailView: View {
    
    var task: Task
    
    var body: some View {
        VStack {
            Text(task.name)
            Text(task.description)
        }
        
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: Task(id: "1", name: "Task 1", description: "Description", done: false))
    }
}
