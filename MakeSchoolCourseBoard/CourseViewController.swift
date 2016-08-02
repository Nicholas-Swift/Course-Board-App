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
    
    var id: String!
    var course: Course!
    
    // Actions
    @IBAction func enrollBarAction(sender: AnyObject) {
        
        if self.enrollBarButton.title == "Enroll" { // ENROLL USER!
            JSONHelper.enrollCourse(id) { (course, error) in
                
                // Change title and then update the previous screen to reload??
                self.enrollBarButton.title = "Enrolled :)"
            }
        }
    }
    
    // Set variables so the table view looks good!
    var headerArray: [String] = []
    var headerDict: [String: Int] = [:] // populated by loadInfo()
    
    // General View Controller stuff
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Course
        tableView.alpha = 0
        self.navigationItem.title = ""
        self.enrollBarButton.title = " "
        loadCourse()
        
        // Table view remove separator
        //tableView.separatorColor = UIColor.clearColor()
        //navigationController?.hidesBarsOnSwipe = true
        
        // Let the cells resize to the correct height based on information
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func loadCourse() {
        JSONHelper.getCourse(id) { (course, error) in
            print(course?.endsOn)
            self.course = course
            
            // Change navbar title
            self.navigationItem.title = self.course.title
            
            // Change the bar button to 'post' if student is enrolled in course.
            if self.course.students.contains(LoginHelper.id) {
                self.enrollBarButton.title = "Post"
                //self.enrollBarButton.tintColor = UIColor.greenColor()
            }
            else {
                self.enrollBarButton.title = "Enroll"
            }
            
            // Load the posts
            JSONHelper.getCoursePosts(course?.id, complete: { (posts, error) in
                self.course.postUser = posts.map{$0.user}
                
                // Load info in
                self.loadInfo()
                
                // Show info once everything is loaded
                self.tableView.reloadData()
                UIView.animateWithDuration(0.2, animations: {
                    self.tableView.alpha = 1
                })
            })
        }
    }
    
    func loadInfo() {
        
        // Set up headerArray
        headerArray = ["Course Information", "Objectives", "Description", "Participants", "Products", "Anouncements"]
        
        // Course Information
        var courseInfoNum = 0
        
        if let _ = course.instructor { if course.instructor != "" { courseInfoNum += 1 }} // course.instructor
        if let _ = course.startsOn { if course.startsOn != "" { courseInfoNum += 1 }}
        if let _ = course.hours { if course.hours != "" { courseInfoNum += 1 }}
        if let _ = course.location { if course.location != "" { courseInfoNum += 1 }}
        
        // Objectives
        var objectivesNum = 0
        if let _ = course.objectives { objectivesNum = course.objectives.count }
        
        // Description
        var descriptionNum = 0
        if let _ = course.description { if course.description != "" { descriptionNum = 1 }}
        
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
    
    // Segue, look down in tableView
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // If going to account
        if segue.identifier == "toAccount" {
            let id = sender as! String
            
            let destination = segue.destinationViewController as! AccountViewController
            destination.id = id
            
            print(id)
        }
        
        // If going to product
        else if segue.identifier == "toProduct" {
            let id = sender as! String
            
            let destination = segue.destinationViewController as! ProductViewController
            destination.id = id
            
            print(id)
        }
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
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    /*func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CourseHeaderCell
        headerCell.headerTitleLabel.text = headerArray[section]
        
        return headerCell
    }*/
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tempArray = ["Course Information", "Objectives", "Description", "Participants", "Products", "Anouncements"]
        
        if headerArray[indexPath.section] == tempArray[0] {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
                
                cell.infoButton.setTitle(course.instructorName ?? "", forState: .Normal)
                
                // Set up the action to go to instructor
                //cell.infoButton.addTarget(self, action: #selector(CourseViewController.cellInstructor), forControlEvents: .TouchUpInside)
                
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
            
            cell.infoButton.setTitle(course.studentNames[indexPath.row] ?? "", forState: .Normal) // course.students
            
            // Set up the action to go to student
            cell.infoButton.addTarget(self, action: #selector(CourseViewController.cellStudent), forControlEvents: .TouchUpInside)
            
            return cell
        }
        else if headerArray[indexPath.section] == tempArray[4] {
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(course.productNames[indexPath.row] ?? "", forState: .Normal) // course.products
            
            // Set up the action to go to product
            cell.infoButton.addTarget(self, action: #selector(CourseViewController.cellProduct), forControlEvents: .TouchUpInside)
            
            return cell
        }
        else if headerArray[indexPath.section] == tempArray[5] {
            let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! CoursePostCell
            
            cell.infoLabel.text = course.postBodies[indexPath.row]
            cell.footerLabel.text = "Posted by " + course.postUser[indexPath.row] + " on " + DateHelper.toShortDate(course.postCreated[indexPath.row])
            
            return cell

        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            return cell
        }
    }
    
    // For cell button touches
    
    func cellInstructor(sender: UIButton) {
        //print(sender.titleLabel?.text)
        
        print("instructor")
        print("Segue to \(course.instructor) ... \(course.instructorName)")
        
        performSegueWithIdentifier("toAccount", sender: course.instructor) // Segue to account
    }
    
    func cellStudent(sender: UIButton) {
        //print(sender.titleLabel?.text)
        
        var index = -1
        for i in 0...course.studentNames.count-1 {
            if sender.titleLabel?.text == course.studentNames[i] {
                index = i
                break
            }
        }
        
        if index >= 0 {
            print("student")
            print("Segue to \(course.students[index]) ... \(course.studentNames[index])")
            
            performSegueWithIdentifier("toAccount", sender: course.students[index]) // Segue to account
        }
    }
    
    func cellProduct(sender: UIButton) {
        //print(sender.titleLabel?.text)
        
        var index = -1
        for i in 0...course.productNames.count-1 {
            if sender.titleLabel?.text == course.productNames[i] {
                index = i
                break
            }
        }
        
        if index >= 0 {
            print("Segue to \(course.products[index]) ... \(course.productNames[index])")
            
            performSegueWithIdentifier("toProduct", sender: course.products[index]) // Segue to account
        }
    }
    
}