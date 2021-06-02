//
//  TaskRowViewModel.swift
//  ios-swift-start
//
//  Created by alopezh on 16/02/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation
import InjectPropertyWrapper
import Combine

class TaskViewModel: ObservableObject, Identifiable, Hashable, AlertViewModel {
    
    private var cancelables = Set<AnyCancellable>()
    
    @Inject
    private var tasksUseCase: TasksUseCase
    
    @Published var loading = false
    var error: LocalizedError?
    
    var id: String
    
    @Published var name: String
    @Published var description: String
    
    @Published var done: Bool = false
    
    init() {
        self.id = "0"
        self.name = ""
        self.description = ""
        self.done = false
    }
    
    init(task: Task) {
        self.name = task.name
        self.done = task.done
        self.description = task.description
        self.id = task.id
    }
    
    func save() {
        
        loading = true
        
        tasksUseCase.update(task: mapToData())
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: DispatchQueue.main)
        .catch { error -> AnyPublisher<Task, Never> in
            self.error = error
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }.handleEvents( receiveCompletion: { [weak self] _ in
            self?.loading = false
        }).sink { [weak self] in self?.load(task: $0) }
        .store(in: &cancelables)
    }
    
    func reset() {
        
    }
    
    static func == (lhs: TaskViewModel, rhs: TaskViewModel) -> Bool {
        lhs.id == rhs.id && lhs.done == rhs.done
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    private func load(task: Task) {
        self.name = task.name
        self.done = task.done
        self.description = task.description
    }
    
    private func mapToData() -> Task {
        Task(id: id, name: name, description: description, done: done)
    }
    
}
