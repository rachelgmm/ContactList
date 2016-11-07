//
//  ContactListDataProvider.swift
//  ContactList
//
//  Created by Nishadh Shrestha on 11/10/15.
//  Copyright © 2015 Nishadh Shrestha. All rights reserved.
//

import Foundation
import UIKit

/// Options to select sorting order
public enum SortType {
    case None
    case Ascending
    case Descending
}


/// Gets data by invoking GetUsers API, filters and formats the data for presenting using UITableView
class ContactListDataProvider: NSObject {
    
    private weak var tableView: UITableView?
    private var users: Array<User>? // Result from API retained for later use
    
    // Used to fill table data
    var filter: String = ""
    var sortType: SortType = SortType.Descending
    private var tableData: OrderedDictionary<String, Array<User>> = OrderedDictionary()
    
    // Used to fill table section index
    private let sectionIndices: Array<String> = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
        "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
        "W", "X", "Y", "Z"]
    
    init(tableView: UITableView, searchBar: UISearchBar) {
        super.init()
        self.tableView = tableView
        tableView.sectionIndexBackgroundColor = UIColor.clearColor()
        tableView.sectionIndexColor = UIColor.darkGrayColor()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    func populateTable(completionHandler: ((APIError?) -> Void)?) {
        APIServices.getUsers { (users, error) -> Void in
            if let error = error {
                if let completionHandler = completionHandler {
                    completionHandler(error)
                }
                return // Can't go further
            }
            
            self.users = users
            self.populateWithFilterAndSorting()
            if let completionHandler = completionHandler {
                completionHandler(nil)
            }
        }
    }
    
    func populateWithFilterAndSorting() {
        if let tableView = self.tableView, var users = self.users {
            
            // Sort based on user preference
            if self.sortType == SortType.Ascending {
                users.sortInPlace({$0.name < $1.name})
            } else if self.sortType == SortType.Descending {
                users.sortInPlace({$0.name > $1.name})
            }
            
            // Clear old data
            self.tableData.removeAll()
            for user in users {
                if !self.filter.isEmpty && !user.name.lowercaseString.containsString(self.filter.lowercaseString) {
                    continue
                }
                
                let key = user.name[0].uppercaseString // first letter of the name is the
                var contacts: Array<User>
                
                if let value = self.tableData[key] { // if the key already exists
                    contacts = value
                    contacts.append(user)
                } else { // if the key doesn't already exists in our dictionary
                    contacts = [user]
                }
                self.tableData.updateValue(contacts, forKey: key)
            }
            tableView.reloadData()
        }
    }
    
    func getSelectedUser() -> User? {
        if let indexPath = self.tableView?.indexPathForSelectedRow {
            return self.tableData.atIndex(indexPath.section)!.value[indexPath.row]
        }
        return nil
    }
}

// MARK: - UITableViewDataSource
// Handles data passing to UITableView
extension ContactListDataProvider: UITableViewDataSource, UITableViewDelegate {
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return self.sortType == SortType.Descending ? self.sectionIndices.reverse() : self.sectionIndices
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.tableData.atIndex(section)!.key
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.atIndex(section)!.value.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let contact = self.tableData.atIndex(indexPath.section)!.value[indexPath.row]
        let labelName: UILabel = cell.viewWithTag(1) as! UILabel
        let labelEmail: UILabel = cell.viewWithTag(2) as! UILabel
        
        labelName.text = contact.name
        labelEmail.text = contact.email
        
        return cell
    }
}

// MARK: - UITableViewDataSource
// Handles searching
extension ContactListDataProvider: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.filter = searchText
        self.populateWithFilterAndSorting()
    }
}