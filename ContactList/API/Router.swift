//
//  Router.swift
//  ContactList
//
//  Created by Nishadh Shrestha on 11/10/15.
//  Copyright © 2015 Nishadh Shrestha. All rights reserved.
//

import Alamofire

/// Maintains all the end-points exposed by the web services
/// Also enforces that required parameters for each API is provided.
enum Router: URLRequestConvertible {
    static let baseURLString = "http://jsonplaceholder.typicode.com" // Base url for our web services
    case GetUsers() // Get users service
    
    // MARK: URLRequestConvertible
    var URLRequest: NSMutableURLRequest {
        let result: (path: String, parameters: [String: AnyObject]) = {
            switch self {
            case .GetUsers():
                return ("/users", [:]) // No parameters
            }
        }()
        
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        let encoding = Alamofire.ParameterEncoding.URL
        
        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
}