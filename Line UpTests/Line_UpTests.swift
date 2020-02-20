//
//  Line_UpTests.swift
//  Line UpTests
//
//  Created by Sreenikhil Kollu on 2/18/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//  Our Application is: Line Up

import XCTest
@testable import Line_Up

class Line_UpTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUser() {
        XCTAssertTrue(true);
        let sampleuser = User.init(firstname: "John", lastname: "Doe", email: "John123@gmail.com", username: "jdoe67", password: "John_4567");
        XCTAssertNotNil(sampleuser);
    }
    
    func testBadUser(){
        let badsampleuser = User.init(firstname: "", lastname: "", email: "John456@gmail.com", username: "jdoe901", password: "John_1234");
        XCTAssertNil(badsampleuser);
    }
    
    // Test case to check if number of tasks in a list is 0 in the beginning and
    // when added the the count is changing
    func testListsAddTask(){
        let t = Task.init(task_Name: "IOS Class", due_Date: "02/20/2020", completed: false, Remainder: false)
        let list = List.init()
        XCTAssertEqual(0, list.tasks.count)
        list.addTask(task: t!)
        XCTAssertEqual(1, list.tasks.count)
    }
    
    //Number of tasks with remainder set to true
    func testRemainderSetTasks(){
        let t1 = Task.init(task_Name: "IOS Class", due_Date: "02/20/2020", completed: false, Remainder: false)
        let t2 = Task.init(task_Name: "IOS Class", due_Date: "02/20/2020", completed: false, Remainder: true)
        let t3 = Task.init(task_Name: "IOS Class", due_Date: "02/20/2020", completed: false, Remainder: true)
        let list = List.init()
        list.addTask(task: t1!)
        list.addTask(task: t2!)
        list.addTask(task: t3!)
        XCTAssertEqual(2.0,list.remaindeIsTrue())
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
