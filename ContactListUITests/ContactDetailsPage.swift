//
//  ContactDetailsPage.swift
//  ContactList
//
//  Created by Rachel Guo on 8/11/16.
//  Copyright © 2016 Nishadh Shrestha. All rights reserved.
//

import Foundation
import XCTest

class ContactDetailsPage {
    
    var application: XCUIApplication = {
        let app = XCUIApplication()
        return app
        
    }()
    
    func getContactDetail(field: String) -> String {
        return getContactDetailsTable().cells[field].staticTexts.elementBoundByIndex(1).label        
    }
    
    private func getContactDetailsTable() -> XCUIElement {
        return self.application.tables["ContactDetailsTable"]
    }
    
}
