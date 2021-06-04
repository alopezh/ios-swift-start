//
//  Mocker.swift
//  ios-swift-start
//
//  Created by alopezh on 04/06/2021.
//  Copyright © 2021 com.herranz.all. All rights reserved.
//

import Foundation
import XCTest

class Mocker {
    
    private var mockedFuncs: [String: MockedFuncCall] = [:]
    
    private var name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    func registerMock(_ fn: String, responses: [Any?]? = nil) {
        mockedFuncs[fn] = MockedFuncCall(name: fn, responses: responses)
    }
    
    func verify(_ fn: String, called: VerifyCount = .atLeastOnce) -> MockedFuncCall? {
        if let mockedFunc = mockedFuncs[fn] {
            mockedFunc.verify(called: called)
            return mockedFunc
        }
        
        if case .never = called {
            return nil
        }
        
        XCTFail("Method \(fn) not called")
        return nil
    }
    
    func paramCaptured(_ fn: String, position: Int = 0) -> [String:Any?]? {
        if let mock = mockedFuncs[fn] {
            return mock.getCapturedParams(position: position)
        }
        return nil
    }

    func call(_ fn: String, params: [String:Any?]? = nil) -> Any? {
        if let mockedFunc = mockedFuncs[fn] {
            return mockedFunc.call(params: params)
        }
        registerMock(fn)
        return call(fn, params: params)
    }
    
    func verifyNoMoreInteractions() {
        mockedFuncs.values.forEach { $0.verifyNoMoreInteractions(className: name) }
    }
}

enum VerifyCount {
    case atLeastOnce
    case moreThan(Int)
    case lessThan(Int)
    case exact(Int)
    case never
}

enum When {
    case after
    case before
}

class MockedFuncCall {
    
    private var name: String
    private var count: Int = 0
    private var responses: [Any?]?
    private var paramList: [[String:Any?]?] = []
    private var verifiedCount = 0
    private var timeStamps: [Date] = []
    
    init(name: String, responses: [Any?]?) {
        self.name = name
        self.responses = responses
    }
    
    private func getCurrentResponse() -> Any? {
        if let responses = responses, count >= responses.count {
            return responses[responses.count - 1]
        }
        return responses?[count] ?? nil
    }
    
    func call(params: [String:Any?]?) -> Any? {
        let response = getCurrentResponse()
        paramList.append(params)
        timeStamps.append(Date())
        count += 1
        return response
    }
    
    func getCapturedParams(position: Int) -> [String:Any?]? {
        if position > paramList.count {
            return nil
        }
        return paramList[position]
    }
    
    func verify(called: VerifyCount = .atLeastOnce) {
        switch called {
        case .atLeastOnce:
            verifiedCount += 1
            if count < 1 {
                XCTFail("Func \(name) not called at least once: \( count)")
            }
        case .moreThan(let times):
            verifiedCount += times
            if count <= times {
                XCTFail("Func \(name) not called more than \(times) times: \( count) ")
            }
        case .lessThan(let times):
            verifiedCount += times
            if count >= times {
                XCTFail("Func \(name) not called less than \(times) times: \( count)")
            }
        case .exact(let times):
            verifiedCount += times
            if count != times {
                XCTFail("Func \(name) not called \(times) times: \( count)")
            }
        case .never:
            if count > 0 {
                XCTFail("Func \(name) is called and it souldn't: \( count)")
            }
        }
    }
    
    func verifyNoMoreInteractions(className: String?) {
        let className = className ?? ""
        if count > verifiedCount {
            XCTFail("Func \(className).\(name) received more interactions: \(count) than verified \(verifiedCount)")
        }
    }
    
    func verify(called: When = .before, _ funcCall: MockedFuncCall?, time: Int = 0) {
        if let funcCall = funcCall {
            switch called {
            case .after:
                if timeStamps[time] < funcCall.timeStamps[time] {
                    XCTFail("Func \(name) is called before \(funcCall.name) and it should be caled after")
                }
            case .before:
                if timeStamps[time] > funcCall.timeStamps[time] {
                    XCTFail("Func \(name) is called after \(funcCall.name) and it should be called before")
                }
            }
        } else {
            XCTFail("Second func never called")
        }
    }
    
}
