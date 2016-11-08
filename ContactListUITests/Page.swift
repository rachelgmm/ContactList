//
//  Page.swift
//  ContactList
//
//  Created by Rachel Guo on 9/11/16.
//  Copyright © 2016 Nishadh Shrestha. All rights reserved.
//

import Foundation
import XCTest

class Page {
    
    var application: XCUIApplication = {
        let app = XCUIApplication()
        return app
        
    }()
    
    func launch() {
        self.application.launch()
    }

}
