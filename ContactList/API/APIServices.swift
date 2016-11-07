//
//  APIServices.swift
//  ContactList
//
//  Created by Nishadh Shrestha on 11/10/15.
//  Copyright © 2015 Nishadh Shrestha. All rights reserved.
//

import Alamofire
import SwiftyJSON

/// Contains methods to invoke the web services
class APIServices {
    class func getUsers(completionHandler: ((users: Array<User>?, error: APIError?) -> Void)) {
        // Call the get users API
        
        NSLog("Waiting for API Response...")
        Alamofire.request(Router.GetUsers()).responseJSON { response in
            NSLog("Got response!")
            if response.result.isSuccess {
                NSLog("Response is successul!")
                if let jsonObject: AnyObject = response.result.value {
                    NSLog("Response is JSON.")
                    var users = Array<User>()
                    let swiftyJsonObject = JSON(jsonObject)
                    
                    // Iterate through the results
                    for entry in swiftyJsonObject.arrayValue {
                        // Object binding
                        let user = User()
                        
                        // General information
                        user.id = entry["id"].stringValue
                        user.name = entry["name"].stringValue
                        user.username = entry["username"].stringValue
                        user.email = entry["email"].stringValue
                        user.phone = entry["phone"].stringValue
                        user.website = entry["website"].stringValue
                        
                        // Address
                        user.address.street = entry["address"]["street"].stringValue
                        user.address.suite = entry["address"]["suite"].stringValue
                        user.address.city = entry["address"]["city"].stringValue
                        user.address.zipcode = entry["address"]["zipcode"].stringValue
                        
                        // Address geo location
                        user.address.geo.latitude = entry["address"]["geo"]["lat"].doubleValue
                        user.address.geo.longitude = entry["address"]["geo"]["lng"].doubleValue
                        
                        // Company
                        user.company.name = entry["company"]["name"].stringValue
                        user.company.catchPhrase = entry["company"]["catchPhrase"].stringValue
                        user.company.bs = entry["company"]["bs"].stringValue
                        
                        users.append(user)
                    }
                    return completionHandler(users: users, error: nil)
                }
            }
            
            // Handle error
            if let error = response.result.error {
                switch (error.domain) {
                case NSCocoaErrorDomain:
                    return completionHandler(users: nil, error: APIError.InvalidData)
                case NSURLErrorDomain:
                    return completionHandler(users: nil, error: APIError.Connection)
                default:
                    break
                }
            }
                
            // Error still not handled, pass unknown
            return completionHandler(users: nil, error: APIError.Unknown)
        }
    }
}