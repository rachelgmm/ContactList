//
//  ContactListPage.swift
//  ContactList
//
//  Created by Rachel Guo on 13/11/16.
//  Copyright © 2016 Nishadh Shrestha. All rights reserved.
//

import Foundation
import XCTest

class ContactListPage {
    
    var application: XCUIApplication {
        let app = XCUIApplication()
        return app
    }
    
    func openContactDetails(contactName: String)  {
        getContactListTable().staticTexts[contactName].tap()
    }
    
    private func getContactListTable() -> XCUIElement {
        return self.application.tables["ContactListTable"]
    }

}
