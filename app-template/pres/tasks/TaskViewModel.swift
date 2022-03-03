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

    var id: UUID

    @Published var name: String
    @Published var description: String

    @Published var done = false

    private var modified: Bool
    private var new: Bool

    init() {
        self.id = UUID.init()
        self.name = "New Task"
        self.description = ""
        self.done = false
        self.modified = false
        self.new = true
    }

    init(task: TaskDM) {
        self.name = task.name
        self.done = task.done
        self.description = task.description
        self.id = task.id
        self.modified = task.modified
        self.new = task.new
    }

    func save() {
        loading = true

        tasksUseCase.update(task: toDomain())
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: DispatchQueue.main)
        .catch { error -> AnyPublisher<TaskDM, Never> in
            self.error = error
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }.handleEvents( receiveCompletion: { [weak self] _ in
            self?.loading = false
        }).sink { [weak self] in self?.load(task: $0) }
        .store(in: &cancelables)
    }

    func reset() {
        // TODO: Call service to restore data
    }

    static func == (lhs: TaskViewModel, rhs: TaskViewModel) -> Bool {
        lhs.id == rhs.id && lhs.done == rhs.done
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    private func load(task: TaskDM) {
        self.name = task.name
        self.done = task.done
        self.description = task.description
        self.done = task.done
        self.modified = task.modified
    }

    func toDomain() -> TaskDM {
        TaskDM(id: id, name: name, description: description, done: done, modified: modified, new: new)
    }
}
