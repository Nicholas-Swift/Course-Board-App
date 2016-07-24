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
    @IBOutlet weak var enrollBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var course: Course!
    
    // Actions
    @IBAction func enrollBarAction(sender: AnyObject) {
        JSONHelper.enrollCourse(course.id) { (course, error) in
            self.enrollBarButton.title = "Enrolled :)"
        }
    }
    
    // Set variables so the table view looks good!
    var headerArray = ["Course Information", "Objectives", "Description", "Participants", "Products", "Anouncements"]
    var headerDict: [String: Int] = [:] // populated by loadInfo()
    
    // General View Controller stuff
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NOTE: Loading the courses is in CoursesViewController.swift
        
        // Change the bar button to 'enrolled' if student is enrolled in course.
        if course.students.contains(LoginHelper.id) {
            enrollBarButton.title = "Enrolled :)"
            enrollBarButton.enabled = false
        }
        
        // nav bar title
        self.navigationItem.title = course.title
        
        // Load up the table view with correct info
        loadInfo()
        
        // Table view remove separator
        tableView.separatorColor = UIColor.clearColor()
        
        // Let the cells resize to the correct height based on information
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func loadInfo() {
        // Course Information
        var courseInfoNum = 0
        if let _ = course.instructorName { courseInfoNum += 1 } // course.instructor
        if let _ = course.startsOn { courseInfoNum += 1 }
        if let _ = course.hours { courseInfoNum += 1 }
        if let _ = course.location { courseInfoNum += 1 }
        
        // Objectives
        var objectivesNum = 0
        if let _ = course.objectives { objectivesNum = course.objectives.count }
        
        // Description
        var descriptionNum = 0
        if let _ = course.description { descriptionNum = 1 }
        
        // Participants
        var participantsNum = 0
        if let _ = course.students { participantsNum = course.students.count }
        
        // Products
        var productsNum = 0
        if let _ = course.products { productsNum = course.products.count }
        
        // Anouncements
        var anouncementsNum = 0
        if let _ = course.posts { anouncementsNum = course.posts.count }
        
        // Remove from array and dictionary as needed
        let tempArray = [courseInfoNum, objectivesNum, descriptionNum, participantsNum, productsNum, anouncementsNum]
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

extension CourseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return headerArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let myNum = headerDict[headerArray[section]]!
        
        return myNum
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerArray[section]
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CourseHeaderCell
        headerCell.headerTitleLabel.text = headerArray[section]
        
        return headerCell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tempArray = ["Course Information", "Objectives", "Description", "Participants", "Products", "Anouncements"]
        
        if headerArray[indexPath.section] == tempArray[0] {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
                cell.infoButton.setTitle(course.instructorName ?? "", forState: .Normal) // course.instructor
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
        }
        else if headerArray[indexPath.section] == tempArray[1] {
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            cell.infoLabel.text = course.objectives[indexPath.row]
            
            return cell
        }
        else if headerArray[indexPath.section] == tempArray[2] {
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            cell.infoLabel.text = course.description
            
            return cell
        }
        else if headerArray[indexPath.section] == tempArray[3] {
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(course.studentNames[indexPath.row] ?? "", forState: .Normal) // course.student
            
            return cell
        }
        else if headerArray[indexPath.section] == tempArray[4] {
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(course.products[indexPath.row] ?? "", forState: .Normal)
            
            return cell
        }
        else if headerArray[indexPath.section] == tempArray[5] {
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            return cell
        }
    }
}