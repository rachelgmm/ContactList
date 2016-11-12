//
//  ViewContactDetailsFeature.swift
//  ContactList
//
//  Created by Rachel Guo on 13/11/16.
//  Copyright © 2016 Nishadh Shrestha. All rights reserved.
//

import Foundation
import XCTest
import XCTest_Gherkin

class viewContactDetailsFeature: XCTestCase {
    func testViewContactCity() {
        Given("I have a contact's city of address")
        And("I open my contact list")
        When("I tap on the contact")
        Then("I can see their city of address")
    }
}
