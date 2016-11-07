//
//  Utils.swift
//  ContactList
//
//  Created by Nishadh Shrestha on 11/10/15.
//  Copyright © 2015 Nishadh Shrestha. All rights reserved.
//

import UIKit

/// Holds methods used commonly throughout the application
class Utils {
    // Launches an AlertController with single OK button
    class func showAlert (parent: UIViewController!, title: String, message: String, okActionHandler: ((UIAlertAction!) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: okActionHandler))
        parent.presentViewController(alert, animated: true, completion: nil)
    }
    
    // Launches an AlertController with two (Ok / Cancel) button
    class func showAlertWithOkCancel (parent: UIViewController!, title: String, message: String, okActionHandler: ((UIAlertAction!) -> Void)?, cancelActionHandler: ((UIAlertAction!) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: okActionHandler))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: cancelActionHandler))
        parent.presentViewController(alert, animated: true, completion: nil)
    }
}
