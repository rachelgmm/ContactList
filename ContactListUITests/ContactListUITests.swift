//
//  ContactListUITests.swift
//  ContactListUITests
//
//  Created by Rachel Guo on 7/11/16.
//  Copyright © 2016 Nishadh Shrestha. All rights reserved.
//

import XCTest
import Nimble

class ContactListUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        app.tables["ContactListTable"].staticTexts["Clementine Bauch"].tap()
        
        app.navigationBars["Clementine Bauch"].staticTexts["Clementine Bauch"].tap()
        
        let contactdetailstableTable = XCUIApplication().tables["ContactDetailsTable"]
        let nameStaticText = contactdetailstableTable.cells.containing(.staticText, identifier:"Clementine Bauch").staticTexts["Name"]
        nameStaticText.tap()
        
        contactdetailstableTable.staticTexts["Clementine Bauch"].tap()
        contactdetailstableTable.staticTexts["Street"].tap()
        contactdetailstableTable.staticTexts["Douglas Extension"].tap()
    }
    
}
