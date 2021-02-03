//
//  TaskListViewModel.swift
//  ios-swift-start
//
//  Created by alopezh on 03/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import Combine

class TaskListViewModel : ObservableObject  {
    
    private var cancelables = Set<AnyCancellable>()
    
    private var allTasks: [Task] =
        [ Task(id: "1",name: "Task1", description: "Description", done: false),
          Task(id: "2",name: "Task2", description: "Description", done: false)]
    
    @Published var showNotDoneOnly = false
    
    @Published var filterdTasks: [Task] = []

    init() {
        
        filterdTasks = allTasks

        $showNotDoneOnly.map { notDoneOnly in
            if notDoneOnly {
                return self.filterdTasks.filter { task in
                    !task.done
                }
            }
            return self.allTasks
        }.assign(to: \.filterdTasks, on: self)
        .store(in: &cancelables)
        
    }
    
}
