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
	
	private var taskServiceMock: TaskServiceMock!

	override func setUpWithError() throws {
		cancelables = []
		taskServiceMock = TaskServiceMock()
        sut = TasksUseCaseImpl(taskService: taskServiceMock)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGivenNewElementsThenSaveAllOfThem() throws {
		let tasks = [ Task(id: UUID(), name: "Name1", description: "Desc", done: false, modified: false, new: true),
					  Task(id: UUID(), name: "Name2", description: "Desc", done: false, modified: false, new: true) ]

		taskServiceMock.registerCreateTask([Task(id: UUID(), name: "Name1", description: "Desc", done: false, modified: false, new: true),
											Task(id: UUID(), name: "Name2", description: "Desc", done: false, modified: false, new: true)])

        let responseReceived = expectation(description: "response received")

        var savedTasks: [Task]?

        sut.save(tasks: tasks)
            .catch { error -> AnyPublisher<[Task], Never> in
                XCTFail(error.localizedDescription)
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            }.sink { saved  in
                savedTasks = saved
                responseReceived.fulfill()
            }
            .store(in: &cancelables)

        waitForExpectations(timeout: 1, handler: nil)

		taskServiceMock.verifyCreateTask(called: .exact(2))

        savedTasks?.forEach {
            XCTAssertFalse($0.modified)
            XCTAssertTrue($0.new)
        }

        XCTAssertEqual(savedTasks?.count, tasks.count)
    }
}


class TaskServiceMock: Mocker, TaskService {

	
    init() {
        super.init("TaskApiMock")
    }

    func getTasks() -> AnyPublisher<[Task], Error> {
        call("getTasks") as! AnyPublisher<[Task], Error>
    }

    func updateTask(id: UUID, _ task: Task) -> AnyPublisher<Task, Error> {
        call("updateTask", params: ["task": task]) as! AnyPublisher<Task, Error>
    }
	
	func createTask(_ task: Task) -> AnyPublisher<Task, Error> {
		call("createTask", params: ["task": task]) as! AnyPublisher<Task, Error>
	}

    func registerCreateTask(_ tasks: [Task]) {
        let publisherTasks = tasks.map { Just($0).setFailureType(to: Error.self).eraseToAnyPublisher() }

        registerMock("createTask", responses: publisherTasks )
    }

    func verifyCreateTask(called: VerifyCount = .atLeastOnce) -> MockedFuncCall? {
        verify("createTask", called: called)
    }
}
