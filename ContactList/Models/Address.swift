//
//  Address.swift
//  ContactList
//
//  Created by Nishadh Shrestha on 11/10/15.
//  Copyright © 2015 Nishadh Shrestha. All rights reserved.
//

/// Holds 'Address' information provided by the web service.
class Address {
    var street: String = ""
    var suite: String = ""
    var city: String = ""
    var zipcode: String = ""
    var geo: (latitude: Double, longitude: Double) = (0, 0)
}