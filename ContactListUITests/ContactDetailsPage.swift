//
//  ContactDetailsPage.swift
//  ContactList
//
//  Created by Rachel Guo on 13/11/16.
//  Copyright © 2016 Nishadh Shrestha. All rights reserved.
//

import Foundation
import XCTest

class ContactDetailsPage: Page {
    
    func getContactDetails(field: String) -> String {
        return getContactDetailsTable().cells[field].staticTexts.elementBoundByIndex(1).label
    }
    
    private func getContactDetailsTable() -> XCUIElement {
        return self.application.tables["ContactDetailsTable"]
    }
}
