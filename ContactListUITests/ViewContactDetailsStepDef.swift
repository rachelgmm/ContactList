//
//  ViewContactDetailsStepDef.swift
//  ContactList
//
//  Created by Rachel Guo on 13/11/16.
//  Copyright © 2016 Nishadh Shrestha. All rights reserved.
//

import Foundation
import XCTest_Gherkin
import Nimble

class ViewContactDetailsStepDef : StepDefiner {
    override func defineSteps() {
        step("I have a contact's city of address") {
            // already setup
        }
        
        step("I have a contact's name") {
            // already setup
        }
        
        step("I open my contact list") {
            Page().launch()
        }
        
        step("I tap on the contact") {
            ContactListPage().openContactDetails("Clementine Bauch")
        }
        
        step("I can see the city of address")
        {
            expect(ContactDetailsPage().getContactDetails("City")).to(equal("McKenziehaven"))
        }
        
        step("I can see the name") {
            expect(ContactDetailsPage().getContactDetails("Name")).to(equal("Clementine Bauch"))
        }
        
    }
}
