//
//  CoursesViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/12/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class CoursesViewController: UIViewController {
    
    // Variables
    @IBOutlet weak var tableView: UITableView!
    
    var courses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get courses and fill tableview
        JSONHelper.getAllCourses({ (courses, error) in
            if let courses = courses {
                
                // Load tableview
                self.courses = courses
                self.tableView.reloadData()
            }
        })
        
        // Change to not translucent
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = ColorHelper.blueColor
        self.tabBarController?.tabBar.translucent = false
    }
    
    override func viewWillAppear(animated: Bool) {
        // Unhighlight the highlighted cell        
        if let selection: NSIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(selection, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() 
        // Dispose of any resources that can be recreated.
    }
    
    // For Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destination = segue.destinationViewController as! CourseViewController
        
        let indexPath = tableView.indexPathForSelectedRow
        let course = courses[indexPath!.row]
        
        destination.course = course
    }
}

extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let course = courses[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell") as! CourseCell
        cell.courseTitleLabel.text = course.title
        cell.instructorNameLabel.text = course.instructor
        cell.dateRangeLabel.text = DateHelper.toShortDate(course.startsOn) + " - " + DateHelper.toShortDate(course.endsOn)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}