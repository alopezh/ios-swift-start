//
//  TaskDetailView.swift
//  ios-swift-start
//
//  Created by alopezh on 03/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct TaskDetailView: View {
    
    @ObservedObject var task: TaskViewModel
    
    var body: some View {
        LoadingView(isShowing: $task.loading) {
            NavigationView {
                VStack {
                    Form {
                        Section(header: Text("Task details")) {
                            TextField("Name", text: $task.name)
                            TextField("Description", text: $task.description)
                            Toggle("Done", isOn: $task.done )
                        }
                    }
                    HStack {
                        Button(action: { task.reset() }) {
                            Text("Reset")
                            
                        }.modifier(SecondaryButtonViewModifier())
                        Spacer()
                        Button(action: { task.save() }) {
                            Text("Save")
                           
                        }.modifier(PrimaryButtonViewModifier())
                    }
                }
            }
            
        }.alert(isPresented: task.isPresentingAlert, content: {
            Alert(localizedError: task.error!)
        })
    }
    
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: TaskViewModel())
    }
}
