//
//  ViewContactDetails.swift
//  ContactList
//
//  Created by Rachel Guo on 9/11/16.
//  Copyright © 2016 Nishadh Shrestha. All rights reserved.
//

import Foundation
import Quick
import Nimble

public class ViewContactDetails: QuickSpec {
    
    override public func spec() {
        beforeEach { 
            Page().launch()
            ContactListPage().openContactDetails("Clementine Bauch")
        }
        
        describe("view contact details") {
            context("select a contact from the contact list") {
                
                it("displays contact's name") {
                    expect(ContactDetailsPage().getContactDetail("Name")).to(equal("Clementine Bauch"))
                }
                
                it("displays contact's city") {
                    expect(ContactDetailsPage().getContactDetail("City")).to(equal("McKenziehaven"))
                }
            }
        }
    }
    
}
