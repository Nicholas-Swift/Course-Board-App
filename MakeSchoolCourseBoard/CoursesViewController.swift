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
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    var courses: [MiniCourse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update
        tableView.alpha = 0
        update()
        
        // Pull to refresh to put everything in
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(CoursesViewController.refresh), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        
        // Change to not translucent
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = ColorHelper.blueColor
        self.tabBarController?.tabBar.translucent = false
    }
    
    func refresh() {
        update()
    }
    
    func update() {
        // Remove ability to add course if user is a student
        
        if LoginHelper.role == "Student" {
            addBarButton.enabled = false
            addBarButton.tintColor = UIColor.whiteColor()
        }
        else {
            addBarButton.enabled = true
            addBarButton.tintColor = ColorHelper.blueColor
        }
        
        // Get courses and fill tableview
        //tableView.alpha = 0
        JSONHelper.getAllCourses({ (courses, error) in
            
            if error == nil {
                if let courses = courses {
                    
                    // Load tableview
                    self.courses = courses
                    
                    // Once loaded, animate in
                    self.tableView.reloadData()
                    UIView.animateWithDuration(0.2, animations: {
                        self.tableView.alpha = 1
                    })
                }
            }
            else {
                UpdateHelper.coursesUpdated = false
            }
            
            // End refreshing
            self.refreshControl.endRefreshing()
        })
    }
    
    override func viewWillAppear(animated: Bool) {

        // Update
        if UpdateHelper.coursesUpdated == false {
            self.update()
            UpdateHelper.coursesUpdated = true
        }
        
        // Unhighlight the highlighted cell        
        if let selection: NSIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(selection, animated: true)
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() 
        // Dispose of any resources that can be recreated.
    }
    
    // For Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "viewCourse" {
            let destination = segue.destinationViewController as! CourseViewController
            
            let indexPath = tableView.indexPathForSelectedRow
            let course = courses[indexPath!.section]
            
            destination.id = course.id
        }
        else {
            //let destination = segue.destinationViewController as! NewCourseViewController
        }
    }
}

extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Set up stylistic properties
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == tableView.numberOfSections-1 {
            return 10
        }
        return 5
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 5
    }
    
    // Table View Information setting
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return courses.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let course = courses[indexPath.section]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell") as! CourseCell
        cell.courseTitleLabel.text = course.title
        cell.instructorNameLabel.text = course.instructorName // course.instructor
        cell.dateRangeLabel.text = course.dates
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}