//
//  TaskRow.swift
//  ios-swift-start
//
//  Created by alopezh on 03/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct TaskRow: View {
    @Binding var task: Task
    
    var body: some View {
        HStack {
            Text(task.name)
//            TODO change to custom checkbox
            Spacer()
            Toggle("", isOn: $task.done)
        }.padding()
    }
}

struct TaskRow_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            TaskRow(task: .constant(Task(id: "1", name: "Task 1", description: "Description", done: false)))
            TaskRow(task: .constant( Task(id: "2", name: "Task 2", description: "Description", done: true)))
        }.previewLayout(.fixed(width: 300, height: 70))
    }
}
