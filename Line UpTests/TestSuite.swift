//
//  TestSuite.swift
//  Line UpTests
//
//  Created by Sreenikhil Kollu on 5/11/20.
//  Copyright © 2020 Sreenikhil Kollu. All rights reserved.
//

import Foundation
import XCTest
@testable import Line_Up

class CustomTest: XCTestCase{
    
    func GoodUser() {
        let sample = User.init(id: "1234", data:["firstname":"sreenikhil",
                                                 "lastname": "kollu",
                                                 "email": "kollu1996@gmail.com",
                                                 "password": "qlnKLO_1962"
        ])
        XCTAssertNotNil(sample)
    }
    
}
