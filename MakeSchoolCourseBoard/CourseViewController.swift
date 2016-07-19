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
    var dictionary: [String: [String]!] = [:]
    var array: [String]!
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NOTE: Loading the courses is in CoursesViewController.swift
        
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
        return dictionary.keys.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let myNum = dictionary[array[section]]!.count
        
        return myNum
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return array[section]
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Set up the info cell
        
        if array[indexPath.section] == "Instructor" {
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell", forIndexPath: indexPath) as! CourseButtonTableViewCell
            
            let myInfo = dictionary[array[indexPath.section]]![indexPath.row]
            cell.informationButton.setTitle(myInfo, forState: .Normal)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell", forIndexPath: indexPath) as! CourseInfoTableViewCell
        
        let myInfo = dictionary[array[indexPath.section]]![indexPath.row]
        
        cell.informationLabel.text = myInfo
        
        return cell
    }
    
}