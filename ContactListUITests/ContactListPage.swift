//
//  ContactListPage.swift
//  ContactList
//
//  Created by Rachel Guo on 8/11/16.
//  Copyright © 2016 Nishadh Shrestha. All rights reserved.
//

import Foundation
import XCTest

class ContactListPage: Page {
    
    func openContactDetails(contactName: String) -> ContactListPage {
        getContactListTable().staticTexts[contactName].tap()
        return self
    }
    
    private func getContactListTable() -> XCUIElement {
        return self.application.tables["ContactListTable"]
    }

}
