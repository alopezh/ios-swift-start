//
//  TaskListViewModel.swift
//  ios-swift-start
//
//  Created by alopezh on 03/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import Foundation
import Combine
import InjectPropertyWrapper

class TaskListViewModel : ObservableObject  {
    
    private var cancelables = Set<AnyCancellable>()
    
    @Inject
    private var tasksUseCase: TasksUseCase
    
    @Published var filterDone = false

    @Published var tasks: [TaskViewModel] = []
    
    func filter() -> [TaskViewModel]  {
        filterDone ? tasks.filter { !$0.done } : tasks
    }
    
    func fetchTasks() {
        tasksUseCase.getTasks()
        .map { tasks in
            tasks.map { self.map(task: $0) }
        }.catch { error -> AnyPublisher<[TaskViewModel], Never> in
            debugPrint("Error \(error)")
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }.assign(to: \.tasks, on: self)
        .store(in: &cancelables)
    }
    
    private func map(task: Task) -> TaskViewModel {
        let tvm = TaskViewModel(task: task)
        tvm.objectWillChange
            .sink { self.objectWillChange.send() }
            .store(in: &cancelables)
        return tvm
    }
    
}
