//
//  NewCourseViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/12/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation

class NewCourseViewController: UITableViewController {
    
    // Variables
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let newCourseArray = ["Title*", "Instructor", "Start Date", "End Date", "Location", "Hours per Week", "Desciption", "Objectives"]
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change separator color to clear
        tableView.separatorColor = UIColor.clearColor()
        tableView.editing = false
        
        // Let the cells resize to the correct height based on information
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Set up the side menu
        MenuViewController.setupViewController(self, menuButton: menuButton)
        
        // Dismiss keyboard on tap!
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewCourseViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // For TableView
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newCourseArray.count + 1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Set up the header cell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Set up the info cell
        
        if indexPath.row == newCourseArray.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell")
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("FieldCell", forIndexPath: indexPath) as! NewCourseFieldCell
            cell.courseTextLabel.text = newCourseArray[indexPath.row]
            
            return cell
        }
    }
    
    // For Keyboard
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        view.endEditing(true)
    }
}