//
//  ContactDetailsViewController.swift
//  ContactList
//
//  Created by Nishadh Shrestha on 11/10/15.
//  Copyright © 2015 Nishadh Shrestha. All rights reserved.
//

import UIKit
import MapKit

/// Handles UI for View contact details screen
class ContactDetailsViewController: UIViewController {
    // Member vars
    internal weak var user: User?
    
    // Data structure to hold section titles as well as property label and values
    private var tableData: OrderedDictionary<String, Array<(title: String, value: String)>> = OrderedDictionary()
    
    /// IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableContactDetails: UITableView!
    @IBOutlet weak var viewUserImageWrapper: UIView!
    
    /// Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = user!.name
        
        // Set screen title to user's name
        self.title = user!.name
        
        // Construct data to present on tableView
        self.constructTableData()
        
       
        
        // Drop a pin to user's address location
        let userLocation = CLLocationCoordinate2DMake(user!.address.geo.latitude, user!.address.geo.longitude)
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = userLocation
        dropPin.title = user!.name
        mapView.addAnnotation(dropPin)
        mapView.setCenterCoordinate(userLocation, animated: true)
        
        
        self.tableContactDetails.delegate = self
        self.tableContactDetails.dataSource = self
        self.tableContactDetails.accessibilityLabel = "ContactDetailsTable"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ContactDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Formats the data for presenting with UITableView
    func constructTableData() {
        if let user = self.user {
            // Personal details
            var personal: Array<(title: String, value: String)> = []
            personal.append((title: "Name", value: user.name))
            personal.append((title: "Username", value: user.username))
            personal.append((title: "Phone", value: user.phone))
            personal.append((title: "Email", value: user.email))
            personal.append((title: "Website", value: user.website))
            self.tableData.updateValue(personal, forKey: "Personal")
            
            // Address details
            var address: Array<(title: String, value: String)> = []
            address.append((title: "Street", value: user.address.street))
            address.append((title: "Suite", value: user.address.suite))
            address.append((title: "City", value: user.address.city))
            address.append((title: "Zipcode", value: user.address.zipcode))
            self.tableData.updateValue(address, forKey: "Address")
            
            // Company details
            var company: Array<(title: String, value: String)> = []
            company.append((title: "Name", value: user.company.name))
            company.append((title: "Catch Phrase", value: user.company.catchPhrase))
            company.append((title: "BS", value: user.company.bs))
            self.tableData.updateValue(company, forKey: "Company")
        }
        
    }
    
    /// Methods for tableview handling
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableData.atIndex(section)!.key
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20 // Give less height for first section
        }
        return 35
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.atIndex(section)!.value.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let entry = tableData.atIndex(indexPath.section)!.value[indexPath.row]
        let labelTitle: UILabel = cell.viewWithTag(1) as! UILabel
        let labelValue: UILabel = cell.viewWithTag(2) as! UILabel
        
        labelTitle.text = entry.title
        labelValue.text = entry.value
        
        cell.accessibilityLabel = entry.title
        
        return cell
    }
}
