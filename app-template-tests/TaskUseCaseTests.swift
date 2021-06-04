//
//  TaskUseCaseTests.swift
//  ios-swift-startTests
//
//  Created by alopezh on 04/06/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import XCTest
import Combine

@testable import ios_swift_start

class TaskUseCaseTests: XCTestCase {
    
    private var cancelables: Set<AnyCancellable>!
    
    private var sut: TasksUseCaseImpl!
    
    private var taskApiMock: TaskApiMock!

    override func setUpWithError() throws {
        cancelables = []
        taskApiMock = TaskApiMock()
        sut = TasksUseCaseImpl(taskApi: taskApiMock)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGivenNewElementsThenSaveAllOfThem() throws {
        
        let tasks = [ TaskDM(id: UUID(), name: "Name1", description: "Desc", done: false, modified: false, new: true),
                      TaskDM(id: UUID(), name: "Name2", description: "Desc", done: false, modified: false, new: true) ]
        
        taskApiMock.registerCreateTask([Task(id: UUID(), name: "Name1", description: "Desc", done: false), Task(id: UUID(), name: "Name2", description: "Desc", done: false)])
        
        let responseReceived = expectation(description: "response received")
        
        var savedTasks: [TaskDM]?
        
        sut.save(tasks: tasks)
            .catch { error -> AnyPublisher<[TaskDM], Never> in
                XCTFail(error.localizedDescription)
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            }.sink { saved  in
                savedTasks = saved
                responseReceived.fulfill()
            }
            .store(in: &cancelables)
        
        waitForExpectations(timeout: 1, handler: nil)
        
        taskApiMock.verifyCreateTask(called: .exact(2))
        
        savedTasks?.forEach {
            XCTAssertFalse($0.modified)
            XCTAssertFalse($0.new)
        }
        
        XCTAssertEqual(savedTasks?.count, tasks.count)
        
    }

}


class TaskApiMock : Mocker, TaskApi {
    
    init() {
        super.init("TaskApiMock")
    }
    
    func getTasks() -> AnyPublisher<[Task], HttpError> {
        call("getTasks") as! AnyPublisher<[Task], HttpError>
    }
    
    func updateTask(id: UUID, _ task: Task) -> AnyPublisher<Task, HttpError> {
        call("updateTask", params: ["task": task]) as! AnyPublisher<Task, HttpError>
    }
    
    func createTask(_ task: Task) -> AnyPublisher<Task, HttpError> {
        call("createTask", params: ["task": task]) as! AnyPublisher<Task, HttpError>
    }
    
    func registerCreateTask(_ tasks: [Task]) {
        let publisherTasks = tasks.map { Just($0).setFailureType(to: HttpError.self).eraseToAnyPublisher() }
        
        registerMock("createTask", responses: publisherTasks )
    }
    
    func verifyCreateTask(called: VerifyCount = .atLeastOnce) -> MockedFuncCall? {
        verify("createTask", called: called)
    }
    
    
}
