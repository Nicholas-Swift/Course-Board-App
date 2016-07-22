//
//  ProductViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/12/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class ProductViewController: UIViewController {
    
    // Variables
    var product: Product!
    @IBOutlet weak var tableView: UITableView!
    
    let headerArray = ["What problem are you solving?", "Unique Value Proposition", "Customer", "Assumptions about the World", "Your Finished Product", "Your MVP", "Advisor", "Course", "Contributors", "External Links"]
    var headerDict = ["What problem are you solving?": 0, "Unique Value Proposition": 0, "Customer": 0, "Assumptions about the World": 0, "Your Finished Product": 0, "Your MVP": 0, "Advisor": 0, "Course": 0, "Contributors": 0, "External Links": 0]
    
    // General View Controller stuff
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NOTE: Loading the courses is in CoursesViewController.swift
        
        // Load up the table view with correct info
        headerDict["What problem are you solving?"] = 1
        headerDict["Unique Value Proposition"] = 1
        headerDict["Customer"] = 1
        headerDict["Assumptions about the World"] = 1
        headerDict["Your finished Product"] = 1
        headerDict["Your MVP"] = 1
        headerDict["Advisor"] = 1
        headerDict["Course"] = 1
        headerDict["Contributors"] = product.contributors.count
        headerDict["External Links"] = 3
        
        // Let the cells resize to the correct height based on information
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Make table view have no separator
        tableView.separatorColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ProductViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return headerArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let myNum = headerDict[headerArray[section]]!
        
        return myNum
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CourseHeaderCell
        headerCell.headerTitleLabel.text = headerArray[section]
        
        return headerCell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch(indexPath.section) {
        case 0: // Problem
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath) as! CourseTextCell
            
            cell.infoLabel.text = product.problem ?? ""
            
            return cell
        case 1: // Value Prop
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            cell.infoLabel.text = self.product.valueProp ?? ""
            
            return cell
        case 2: // Customer
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            cell.infoLabel.text = self.product.customer ?? ""
            
            return cell
        case 3: // Assumptions
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            cell.infoLabel.text = self.product.assumptions ?? ""
            
            return cell
        case 4: // Finished Product
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(product.finishedProduct ?? "", forState: .Normal)
            
            return cell
        case 5: // MVP
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(product.mvp ?? "", forState: .Normal)
            
            return cell
        case 6: // Advisor
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(product.instructor ?? "", forState: .Normal)
            
            return cell
        case 7: // Course
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(product.course, forState: .Normal)
            
            return cell
        case 8: // Contributors
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(product.contributors[indexPath.row] ?? "", forState: .Normal)
            
            return cell
        case 9: // External links
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            cell.infoButton.setTitle("", forState: .Normal)
            
            if indexPath.row == 0 {
                cell.infoButton.setTitle(product.githubUrl, forState: .Normal)
            }
            else if indexPath.row == 1 {
                cell.infoButton.setTitle(product.agileUrl, forState: .Normal)
            }
            else {
                cell.infoButton.setTitle(product.liveurl, forState: .Normal)
            }
            
            return cell
        default: // DEFAULT WILL RETURN INFO CELL
            let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell") as! CourseInfoCell
            return cell
        }
    }
}