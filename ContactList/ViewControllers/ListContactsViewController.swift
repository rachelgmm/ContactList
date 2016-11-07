//
//  ListContactsViewController.swift
//  ContactList
//
//  Created by Nishadh Shrestha on 11/10/15.
//  Copyright © 2015 Nishadh Shrestha. All rights reserved.
//

import UIKit
import SVProgressHUD

/// Handles UI for the List Contacts (primary) screen
class ListContactsViewController: UITableViewController {
    private var dataProvider: ContactListDataProvider!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = ContactListDataProvider(tableView: self.tableView, searchBar: self.searchBar)
        
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        dataProvider.sortType = SortType.Ascending
        
        if let sortType = defaults.objectForKey("sortType") as? String {
            if (sortType == "desc") {
                dataProvider.sortType = SortType.Descending
            }
        }
        
        SVProgressHUD.showWithStatus("Loading...", maskType: .Gradient)
        dataProvider.populateTable { (error) -> Void in
            SVProgressHUD.dismiss()
            
            // Notify user if an error has occured
            if let error = error {
                switch (error) {
                case .Connection:
                    Utils.showAlert(self, title: "Error", message: "Unable to connect to the server.", okActionHandler: nil)
                    break
                case .InvalidData:
                    Utils.showAlert(self, title: "Error", message: "Server has returned an invalid data.", okActionHandler: nil)
                    break
                default:
                    Utils.showAlert(self, title: "Error", message: "An unknown error has occured while getting data from the server.", okActionHandler: nil)
                    break
                }
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Show sort type option screen
    @IBAction func rightBarButtonTapped(sender: AnyObject) {
        let alert = UIAlertController(title: "Sorting Option", message: "Please select the order by which you contacts should be sorted.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        alert.addAction(UIAlertAction(title: "Ascending", style: .Default , handler: { (action) -> Void in
            defaults.setObject("asc", forKey: "sortType")
            self.dataProvider.sortType = SortType.Ascending
            self.dataProvider.populateWithFilterAndSorting()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Descending", style: .Default , handler: { (action) -> Void in
            defaults.setObject("desc", forKey: "sortType")
            self.dataProvider.sortType = SortType.Descending
            self.dataProvider.populateWithFilterAndSorting()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default , handler: { (action) -> Void in
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueContactDetails" {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
            let vc: ContactDetailsViewController = segue.destinationViewController as! ContactDetailsViewController
            vc.user = self.dataProvider.getSelectedUser()
        }
    }

}
