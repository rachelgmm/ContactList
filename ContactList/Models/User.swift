//
//  User.swift
//  ContactList
//
//  Created by Nishadh Shrestha on 11/10/15.
//  Copyright © 2015 Nishadh Shrestha. All rights reserved.
//

// Holds 'User' information provided by the web service. Class used for pass by reference.
class User {
    var id: String = ""
    var name: String = ""
    var username: String = ""
    var email: String = ""
    var phone: String = ""
    var website: String = ""
    let address: Address = Address()
    let company: Company = Company()
}