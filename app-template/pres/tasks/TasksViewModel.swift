//
//  TaskListViewModel.swift
//  ios-swift-start
//
//  Created by alopezh on 03/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation

class TaskListViewModel : ObservableObject  {
    
    @Published var showNotDoneOnly = false
    
    @Published var tasks = [Task(id: "1",name: "Task1", description: "Description", done: false),
                 Task(id: "2",name: "Task2", description: "Description", done: false)]
    
}
