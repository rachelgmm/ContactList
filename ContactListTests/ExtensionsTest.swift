//
//  ExtensionsTest.swift
//  ExperimentApp
//
//  Created by Nishadh Shrestha on 11/9/15.
//  Copyright © 2015 Nishadh Shrestha. All rights reserved.
//

import XCTest

class ExtensionsTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStringSubstring() {
        var s: String = "Tom & Jerry"
        XCTAssert(s[0] == "T")
        XCTAssert(s[1] == "o")
        
        XCTAssert(s[-1] == "") // Out of range
        
        s = " Unicode♞ "
        XCTAssert(s[10] == "") // Out of range
        XCTAssert(s[0] == " ") // Leading space
        XCTAssert(s[9] == " ") // Trailing space
        XCTAssert(s[8] == "♞") // Unicode character
    }
    
}