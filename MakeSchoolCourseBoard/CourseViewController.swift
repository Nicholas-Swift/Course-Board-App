//
//  CourseViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/13/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class CourseViewController: UITableViewController {
    
    // Variables
    var courses: [Course] = []
    var headerText = ["Instructor", "Date", "Hours Per Week", "Location", "Objectives", "Description", "Anouncements"]
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get courses
        JSONHelper.getCourses { (returnCourses, error) in
            if let returnCourses = returnCourses {
                self.courses = returnCourses
            }
        }
        
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
        return headerText.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowText[section].count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Set up the header cell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CourseHeaderTableViewCell
        cell.headerTitle.text = headerText[section]
        
        return cell
    }
    
    var temp = 0
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Set up the info cell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell", forIndexPath: indexPath) as! CourseInfoTableViewCell
        cell.informationLabel.text = rowStuff[temp]
        temp += 1
        
        return cell
    }
    
}