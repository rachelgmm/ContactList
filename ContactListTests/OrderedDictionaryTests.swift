//
//  OrderedDictionaryTests.swift
//  ExperimentApp
//
//  Created by Nishadh Shrestha on 11/9/15.
//  Copyright © 2015 Nishadh Shrestha. All rights reserved.
//

import XCTest

class OrderedDictionaryTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSubscript() {
        var od: OrderedDictionary<String, Int> = OrderedDictionary()
        od.updateValue(0, forKey: "A")
        od.updateValue(1, forKey: "B")
        od.updateValue(2, forKey: "C")
        XCTAssert(od["C"] == 2)
        XCTAssertNil(od["D"])
    }
    
    func testAtIndex() {
        var od: OrderedDictionary<String, Int> = OrderedDictionary()
        od.updateValue(0, forKey: "A")
        od.updateValue(1, forKey: "B")
        od.updateValue(2, forKey: "C")
        
        let atIndex = od.atIndex(1)
        XCTAssertNotNil(atIndex)
        XCTAssert(atIndex!.key == "B")
        XCTAssert(atIndex!.value == 1)
    }
    
    func testUpdateValue() {
        var od: OrderedDictionary<String, Int> = OrderedDictionary()
        od.updateValue(1, forKey: "A")
        XCTAssertNil(od["B"])
        XCTAssert(od["A"] == 1)
        od.updateValue(1, forKey: "A")
        od.updateValue(-100, forKey: "B")
        od.updateValue(100, forKey: "A")
        od.updateValue(100, forKey: "C")
        od.updateValue(0, forKey: "C")
        XCTAssert(od["A"] == 100)
    }
    
    func testCount() {
        var od: OrderedDictionary<String, String> = OrderedDictionary()
        od.updateValue("X", forKey: "A")
        od.updateValue("Y", forKey: "A")
        od.updateValue("X", forKey: "B")
        XCTAssert(od.count == 2)
        od.removeValueForKey("a")
        XCTAssert(od.count == 2)
        od.removeValueForKey("A")
        XCTAssert(od.count == 1)
    }
    
    func testRemoveValueForKey() {
        var od: OrderedDictionary<String, Int> = OrderedDictionary()
        od.updateValue(1, forKey: "A")
        od.updateValue(1, forKey: "B")
        od.updateValue(2, forKey: "A")
        od.updateValue(1, forKey: "C")
        od.removeValueForKey("A")
        XCTAssertNil(od["A"])
    }
    
    func testRemoveAll() {
        var od: OrderedDictionary<String, Int> = OrderedDictionary()
        od.updateValue(1, forKey: "A")
        od.updateValue(2, forKey: "B")
        od.updateValue(3, forKey: "C")
        od.updateValue(4, forKey: "D")
        od.removeAll()
        XCTAssert(od.count == 0)
        XCTAssertNil(od["A"])
    }
}