//
//  CourseViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/13/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class CourseViewController: UIViewController {
    
    // Variables
    @IBOutlet weak var tableView: UITableView!
    var course: Course!
    
    // Set variables so the table view looks good!
    let headerArray = ["Course Information", "Objectives", "Description", "Participants", "Products", "Anouncements"]
    var headerDict = ["Course Information": 0, "Objectives": 0, "Description": 0, "Participants": 0, "Anouncements": 0]
    
    // General View Controller stuff
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NOTE: Loading the courses is in CoursesViewController.swift
        
        // Load up the table view with correct info
        headerDict[headerArray[0]] = 4 //course info: instructor, dates, hours, location
        headerDict[headerArray[1]] = course.objectives.count //objectives
        headerDict[headerArray[2]] = 1 //description: 1
        headerDict[headerArray[3]] = course.students.count //participants
        headerDict[headerArray[4]] = course.products.count //products
        headerDict[headerArray[5]] = course.posts.count //anouncements
        
        // Table view remove separator
        tableView.separatorColor = UIColor.clearColor()
        
        // Let the cells resize to the correct height based on information
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CourseViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        case 0: // Course Information
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
                cell.infoButton.setTitle(course.instructor ?? "", forState: .Normal)
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
                
                // Format all the information
                let array = [String(DateHelper.toFullDate(course.startsOn) + " - " + DateHelper.toFullDate(course.endsOn)), String(course.hours + " hours per week"), String(course.location)]
                
                // Add the information to the cell
                cell.infoLabel.text = array[indexPath.row-1]
                
                return cell
            }
        case 1: // Objectives
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            cell.infoLabel.text = course.objectives[indexPath.row]
            
            return cell
        case 2: // Description
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            cell.infoLabel.text = course.description
            
            return cell
        case 3: // Participants
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(course.students[indexPath.row] ?? "", forState: .Normal)
            
            return cell
        case 4: // Products
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(course.products[indexPath.row] ?? "", forState: .Normal)
            
            return cell
        case 5: // Anouncements
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            return cell
        default: // DEFAULT WILL RETURN INFO CELL
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            return cell
        }
    }
}