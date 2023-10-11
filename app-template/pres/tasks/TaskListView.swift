//
//  TaskListView.swift
//  ios-swift-start
//
//  Created by alopezh on 03/10/2020.
//  Copyright © 2020 com.herranz.all. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject private var viewModel = TaskListViewModel()

    var body: some View {
        LoadingView(isShowing: $viewModel.loading) {
            NavigationView {
                VStack {
                    Toggle(isOn: $viewModel.filterDone) {
                        Text("Filter done")
                    }.padding()
                    List {
                        ForEach(viewModel.filter(), id: \.self) { task in
                            NavigationLink(destination: TaskDetailView(task: task)) {
                                TaskRowView(task: task)
                            }
                        }
                    }
                    HStack {
                        Button(action: { viewModel.fetchTasks() }) {
                            Text("Reset")
                        }.modifier(SecondaryButtonViewModifier())
                        Spacer()
                        Button(action: { viewModel.save() }) {
                            Text("Save")
                        }.modifier(PrimaryButtonViewModifier())
                    }
                }.navigationBarTitle(
                    Text("Tasks")
                )
                .navigationBarItems(trailing: Button(action: { viewModel.newTask() }) {
                    Image(systemName: "plus").resizable().frame(width: 20.0, height: 20.0)
                })
            }.navigationViewStyle(StackNavigationViewStyle())
        }.onAppear {
            viewModel.fetchTasks()
        }.alertError(
			isPresented: viewModel.isPresentingAlert,
			error: viewModel.error,
			defaultMessage: "Error loading Initial Status"
		)
		
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
