//
//  CoursesViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/12/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class CoursesViewController: UITableViewController {
    
    // Variables
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var courses: [Course] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JSONHelper.getCourses({ (courses, error) in
            if let courses = courses {
                self.courses = courses
            }
        })
        
        MenuViewController.setupViewController(self, menuButton: menuButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() 
        // Dispose of any resources that can be recreated.
    }
    
    // For TableView
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let course = courses[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell") as! CourseCell
        cell.courseTitle.text = course.title
        cell.instructorName.text = course.instructor
        cell.locationLabel.text = course.location
        cell.datesLabel.text = course.startsOn + " - " + course.endsOn
        cell.hoursLabel.text = course.hours
        cell.peopleLabel.text = "NEED TO ADD"
        
        return cell
    }
    
    // For Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destination = segue.destinationViewController as! CourseViewController
        
        let indexPath = tableView.indexPathForSelectedRow
        let course = courses[indexPath!.row]
        
        let dictionary: [String: [String]!] = ["Instructor": [course.instructor], "Date": [course.startsOn + "-" + course.endsOn], "Hours Per Week": [course.hours], "Location": [course.location], "Objectives": course.objectives, "Description": [course.description], "Anouncements": course.posts]
        let array: [String] = ["Instructor", "Date", "Hours Per Week", "Location", "Objectives", "Description", "Anouncements"]
        
        destination.title = course.title
        destination.dictionary = dictionary
        destination.array = array
        
    }
}