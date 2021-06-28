//
//  TaskRow.swift
//  ios-swift-start
//
//  Created by alopezh on 03/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct TaskRowView: View {
    @ObservedObject var task: TaskViewModel

    var body: some View {
        HStack {
            Text(task.name)
            Spacer()
            Toggle("", isOn: $task.done )
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskRowView(task: TaskViewModel())
            TaskRowView(task: TaskViewModel())
        }.previewLayout(.fixed(width: 300, height: 70))
    }
}
