//
//  ProductViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/12/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class ProductViewController: UITableViewController {
    
    // Variables
    var dictionary: [String: [String]!] = [:]
    var array: [String]! = []
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NOTE: Loading the product is in ProductViewController.swift
        
        // Change separator color to clear
        tableView.separatorColor = UIColor.clearColor()
        tableView.editing = false
        
        // Let the cells resize to the correct height based on information
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // For TableView
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return array.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionary[array[section]]!.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Set up the header cell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! ProductHeaderTableViewCell
        cell.headerTitle.text = array[section]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Set up the info cell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell", forIndexPath: indexPath) as! ProductInfoTableViewCell
        let myInfo = dictionary[array[indexPath.section]]![indexPath.row]
        cell.informationLabel.text = myInfo
        
        return cell
    }
    
}