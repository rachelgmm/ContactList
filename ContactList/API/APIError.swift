//
//  APIError.swift
//  ContactList
//
//  Created by Nishadh Shrestha on 11/10/15.
//  Copyright © 2015 Nishadh Shrestha. All rights reserved.
//

/// Errors returned by the API Services methods
enum APIError: ErrorType {
    case Connection
    case InvalidData
    case Unknown
}