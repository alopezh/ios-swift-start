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
import SwiftUI

class TaskListViewModel : ObservableObject  {
    
    private var cancelables = Set<AnyCancellable>()
    
    @Inject
    private var tasksUseCase: TasksUseCase
    
    @Published var filterDone = false

    @Published var tasks: [TaskViewModel] = []
    
    @Published var loading = false
    
    @Published private(set) var error: LocalizedError?
    
    func filter() -> [TaskViewModel]  {
        filterDone ? tasks.filter { !$0.done } : tasks
    }
    
    func fetchTasks() {
        loading = true
        tasksUseCase.getTasks()
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: DispatchQueue.main)
        .map { [weak self] tasks in
            guard let self = self else { return [] }
            return tasks.map { self.map(task: $0) }
        }.catch { error -> AnyPublisher<[TaskViewModel], Never> in
            self.error = error
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }.handleEvents( receiveCompletion: { [weak self] _ in
            self?.loading = false
        }).assign(to: \.tasks, on: self)
        .store(in: &cancelables)
    }
    
    private func map(task: Task) -> TaskViewModel {
        let tvm = TaskViewModel(task: task)
        tvm.objectWillChange
            .sink { self.objectWillChange.send() }
            .store(in: &cancelables)
        return tvm
    }
 
    var isPresentingAlert: Binding<Bool> {
        return Binding<Bool>(get: {
            return self.error != nil
        }, set: { newValue in
            guard !newValue else { return }
            self.error = nil
        })
    }
    
}
