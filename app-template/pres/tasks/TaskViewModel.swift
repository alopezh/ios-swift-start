//
//  TaskRowViewModel.swift
//  ios-swift-start
//
//  Created by alopezh on 16/02/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation

class TaskViewModel: ObservableObject, Identifiable, Hashable {
    
    var id: String { name }
    
    let name: String
    let description: String
    
    @Published var done: Bool = false
    
    init(name: String, description: String, done: Bool = false) {
        self.name = name
        self.description = description
        self.done = done
    }
    
    static func == (lhs: TaskViewModel, rhs: TaskViewModel) -> Bool {
      lhs.id == rhs.id
    }
      
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
}
