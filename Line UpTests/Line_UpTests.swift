//
//  Line_UpTests.swift
//  Line UpTests
//
//  Created by Sreenikhil Kollu on 5/11/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import XCTest
@testable import Line_Up

class Line_UpTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        
        measure {
            
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGood(){
        let sample = User.init(id: "1234", data: [
            "firstname": "sreenikhil",
            "lastname": "kollu",
            "email": "kollu1996@gmail.com",
            "password": "kollu@1234"
        ])
        XCTAssertNotNil(sample)
    }
    
    func badUser(){
        let sample1 = User.init(id: "4567", data: [
            "firstname": false,
            "lastname": "Kandimalla",
            "email": "kandimallanholmes@gmail.com",
            "password": "Venky@1234"
        ])
         XCTAssertNil(sample1)
    }
    
    func goodTask(){
        let task = Tasks.init(id: "7890", data: [
            "task_name": "Read a book",
            "due_Date":   Date(),
            "complated": false,
            "Remainder": false,
            "Notes": "Read only non fictional",
            "ssid": "kollu1996@gmail.com"
            
        ])
        XCTAssertNotNil(task)
    }
    
    func badTask(){
        let task1 = Tasks.init(id: "7890", data: [
            "task_name": 8901,
            "due_Date":   12345,
            "complated": false,
            "Remainder": false,
            "Notes": "Read only non fictional",
            "ssid": "kollu1996@gmail.com"
            
        ])
        XCTAssertNil(task1)
    }

}
