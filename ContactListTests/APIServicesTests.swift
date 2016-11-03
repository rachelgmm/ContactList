//
//  APIServicesTests.swift
//  ExperimentApp
//
//  Created by Nishadh Shrestha on 11/10/15.
//  Copyright © 2015 Nishadh Shrestha. All rights reserved.
//

import XCTest
import OHHTTPStubs // Use this library to mock APIs

class APIServicesTest: XCTestCase {
    override func setUp() {
        super.setUp()
        OHHTTPStubs.onStubActivation() { request, stub in
            NSLog("\(request.URL!) stubbed by \(stub.name).")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testGetUsers() {
        stub(isPath("/users")) { _ in
            // Return our mock JSON file
            return OHHTTPStubsResponse(fileAtPath:OHPathForFile("getusers.json", self.dynamicType)!,
                statusCode:200,
                headers:["Content-Type": "application/json"])
            }.name = "Get users"
        
        
        let expectation = self.expectationWithDescription("Get users")
        
        APIServices.getUsers { (users, error) -> Void in
            NSLog("\(users?.count)")
            XCTAssertNotNil(users)
            XCTAssert(users?.count == 5)
            
            XCTAssertEqual(users![0].name, "") // User with no data should hold empty properties
            
            // Test when partial data is provided
            XCTAssertEqual(users![1].address.city, "") // User has no address data
            XCTAssertEqual(users![1].address.street, "") // User has no address data
            XCTAssertEqual(users![1].address.suite, "") // User has no address data
            XCTAssertEqual(users![1].address.zipcode, "") // User has no address data
            XCTAssertEqual(users![1].address.geo.latitude, 0) // User has no address data
            XCTAssertEqual(users![1].address.geo.longitude, 0) // User has no address data
            
            XCTAssertEqual(users![2].company.name, "") // User has no company data
            XCTAssertEqual(users![2].company.catchPhrase, "") // User has no company data
            XCTAssertEqual(users![2].company.bs, "") // User has no company data

            // Test when invalid data is provided
            XCTAssertEqual(users![2].address.geo.latitude, 0) // Invalid lat is set to 0
            XCTAssertEqual(users![2].address.geo.longitude, 0) // Invalid lng is set to 0
            
            // Test all valid user data is retained
            let user = users![3]
            XCTAssertEqual(user.id, "4")
            XCTAssertEqual(user.name, "Patricia Lebsack")
            XCTAssertEqual(user.username, "Karianne")
            XCTAssertEqual(user.email, "Julianne.OConner@kory.org")
            XCTAssertEqual(user.phone, "493-170-9623 x156")
            XCTAssertEqual(user.website, "kale.biz")
            XCTAssertEqual(user.address.street, "Hoeger Mall")
            XCTAssertEqual(user.address.suite, "Apt. 692")
            XCTAssertEqual(user.address.city, "South Elvis")
            XCTAssertEqual(user.address.zipcode, "53919-4257")
            XCTAssertEqual(user.address.geo.latitude, 29.4572)
            XCTAssertEqual(user.address.geo.longitude, -164.2991)
            XCTAssertEqual(user.company.name, "Robel-Corkery")
            XCTAssertEqual(user.company.catchPhrase, "Multi-tiered zero tolerance productivity")
            XCTAssertEqual(user.company.bs, "transition cutting-edge web services")
            
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(30, handler: nil) // 30 seconds timeout
    }
    
    
    
    func testGetUsersInvalidDataError() {
        stub(isPath("/users")) { _ in
            
            // Return invalid data
            let stubData = "Invalid JSON data".dataUsingEncoding(NSUTF8StringEncoding)
            return OHHTTPStubsResponse(data: stubData!, statusCode:200, headers:nil)
            }.name = "Get users - invalid data"
        
        
        let expectation = self.expectationWithDescription("Get users")
        
        APIServices.getUsers { (users, error) -> Void in
            XCTAssertNil(users)
            XCTAssertNotNil(error)
            XCTAssertEqual(error!, APIError.InvalidData)
            //XCTAssertEqual(users!.name, "")
            //XCTAssertEqual(users![1].id, "2")
            
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(30, handler: nil) // 30 seconds timeout
    }
    
    func testGetUsersConnectionError() {
        stub(isPath("/users")) { _ in
            
            // Return connection error
            let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.CFURLErrorNotConnectedToInternet.rawValue), userInfo:nil)
            return OHHTTPStubsResponse(error:notConnectedError)
            }.name = "Get users - connection error"
        
        
        let expectation = self.expectationWithDescription("Get users")
        
        APIServices.getUsers { (users, error) -> Void in
            XCTAssertNil(users)
            XCTAssertNotNil(error)
            XCTAssertEqual(error!, APIError.Connection)
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(30, handler: nil) // 30 seconds timeout
    }
    
    
}