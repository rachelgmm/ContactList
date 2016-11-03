//
//  Extensions.swift
//  ContactList
//
//  Created by Nishadh Shrestha on 11/10/15.
//  Copyright © 2015 Nishadh Shrestha. All rights reserved.
//

/// Contains some extensions to existing classes
extension String {
    subscript(i: Int) -> String {
        get {
            if (i < 0 || i >= self.startIndex.distanceTo(self.endIndex)) {
                return ""
            }
            
            return String(self[startIndex.advancedBy(i)])
        }
    }
}

