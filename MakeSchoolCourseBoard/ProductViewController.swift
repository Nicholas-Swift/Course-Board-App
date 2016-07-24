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
    @IBOutlet weak var joinBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    // Actions
    @IBAction func joinBarAction(sender: AnyObject) {
        JSONHelper.joinProduct(product.id) { (course, error) in
            self.joinBarButton.title = "Joined :)"
        }
    }
    
    var headerArray = ["What problem are you solving?", "Unique Value Proposition", "Customer", "Assumptions about the World", "Your Finished Product", "Your MVP", "Advisor", "Course", "Contributors", "External Links"]
    var headerDict: [String: Int] = [:]
    
    // General View Controller stuff
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NOTE: Loading the courses is in CoursesViewController.swift
        
        // Change the bar button to 'joined' if student is joined in product.
        if product.contributors.contains(LoginHelper.id) {
            joinBarButton.title = "Joined :)"
            joinBarButton.enabled = false
        }
        
        // Nav bar title
        self.navigationItem.title = product.name
        
        // Load up the table view with correct info
        loadInfo()
        
        // Let the cells resize to the correct height based on information
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Make table view have no separator
        tableView.separatorColor = UIColor.clearColor()
    }
    
    func loadInfo() {
        
        // Problem
        var problemNum = 0
        if let _ = product.problem { if product.problem != "" { problemNum = 1 } }
        
        // Value
        var valueNum = 0
        if let _ = product.valueProp { if product.valueProp != "" { valueNum = 1 } }
        
        // Customer
        var customerNum = 0
        if let _ = product.customer { if product.customer != "" { customerNum = 1 } }
        
        // Assumptions
        var assumptionsNum = 0
        if let _ = product.assumptions { if product.assumptions != "" { assumptionsNum = 1 } }
        
        // Product
        var productNum = 0
        if let _ = product.finishedProduct { if product.finishedProduct != "" { productNum = 1 } }
        
        // MVP
        var mvpNum = 0
        if let _ = product.mvp { if product.mvp != "" { mvpNum = 1 } }
        
        // Advisor
        var advisorNum = 0
        if let _ = product.instructorName { if product.instructorName != "" { advisorNum = 1 } } // product.instructor
        
        // Course
        var courseNum = 0
        if let _ = product.course { if product.course != "" { courseNum = 1 } }
        
        // Contributors
        var contributorsNum = 0
        if let _ = product.contributors { contributorsNum = product.contributors.count }
        
        // External Links
        var linksNum = 0
        if let _ = product.githubUrl { if product.githubUrl != "" { linksNum += 1 } }
        if let _ = product.agileUrl { if product.agileUrl != "" { linksNum += 1 } }
        if let _ = product.liveurl { if product.liveurl != "" { linksNum += 1 } }
        
        // Remove from array and dictionary as needed
        let tempArray = [problemNum, valueNum, customerNum, assumptionsNum, productNum, mvpNum, advisorNum, courseNum, contributorsNum, linksNum]
        var removeArray: [Int] = []
        
        for i in 0...headerArray.count-1 {
            if tempArray[i] == 0 {
                removeArray.append(i)
            }
            else {
                print(headerArray[i])
                let one = headerArray[i]
                print(tempArray[i])
                let two = tempArray[i]
                
                headerDict[one] = two
            }
        }
        var temp = 0
        for i in removeArray {
            headerArray.removeAtIndex(i - temp)
            temp += 1
        }
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
        return 30
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tempArray = ["What problem are you solving?", "Unique Value Proposition", "Customer", "Assumptions about the World", "Your Finished Product", "Your MVP", "Advisor", "Course", "Contributors", "External Links"]
        
        if headerArray[indexPath.section] == tempArray[0] {
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath) as! CourseTextCell
            
            cell.infoLabel.text = product.problem ?? ""
            
            return cell
        }
        else if headerArray[indexPath.section] == tempArray[1] {
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            cell.infoLabel.text = self.product.valueProp ?? ""
            
            return cell
        }
        else if headerArray[indexPath.section] == tempArray[2] {
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            cell.infoLabel.text = self.product.customer ?? ""
            
            return cell
        }
        else if headerArray[indexPath.section] == tempArray[3] {
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            cell.infoLabel.text = self.product.assumptions ?? ""
            
            return cell
        }
        else if headerArray[indexPath.section] == tempArray[4] {
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(product.finishedProduct ?? "", forState: .Normal)
            
            return cell
        }
        else if headerArray[indexPath.section] == tempArray[5] {
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(product.mvp ?? "", forState: .Normal)
            
            return cell
        }
        else if headerArray[indexPath.section] == tempArray[6] {
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(product.instructorName ?? "", forState: .Normal) // product.instructor
            
            return cell
        }
        else if headerArray[indexPath.section] == tempArray[7] {
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(product.course, forState: .Normal)
            
            return cell
        }
        else if headerArray[indexPath.section] == tempArray[8] {
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(product.contributorNames[indexPath.row] ?? "", forState: .Normal) // product.contributor
            
            return cell
        }
        else if headerArray[indexPath.section] == tempArray[9] {
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            cell.infoButton.setTitle("", forState: .Normal)
            
            var tempArray: [String] = []
            if product.githubUrl != "" {
                tempArray.append(product.githubUrl)
            }
            if product.agileUrl != "" {
                tempArray.append(product.agileUrl)
            }
            if product.liveurl != "" {
                tempArray.append(product.liveurl)
            }
            
            cell.infoButton.setTitle(tempArray[indexPath.row], forState: .Normal)
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell") as! CourseInfoCell
            return cell
        }
    }
}