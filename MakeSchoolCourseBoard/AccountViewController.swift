//
//  AccountViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/12/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class AccountViewController: UITableViewController {
    
    // Variables
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let array = ["Info", "Courses", "Products", "Anouncements"]
    var dict = ["Info": 1, "Courses": 0, "Products": 0, "Anouncements": 0]
    var user = User()
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Let the cells resize to the correct height based on information
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        JSONHelper.getMe { (user, error) in
            self.dict["Courses"] = user.courses.count
            self.dict["Products"] = user.products.count
            
            self.user = user
            
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        // Set up the menu
        MenuViewController.setupViewController(self, menuButton: menuButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // For TableView
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dict[array[section]] ?? 0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return array[section]
    }
    
    /*override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }*/
    
    /*override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Set up the header cell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell")
        
        return cell
    }*/
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Set up the info cell
        
        let mySection = array[indexPath.section]
        
        if mySection == "Info" {
            let cell = tableView.dequeueReusableCellWithIdentifier("NameCell") as! AccountNameTableViewCell
            cell.fullNameLabel.text = user.fullname
            cell.usernameLabel.text = user.username
            return cell
        }
        else if mySection == "Courses" {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("LinkCell") as! AccountCourseTableViewCell
            cell.linkButton.setTitle(user.courses[indexPath.row], forState: .Normal)
            return cell
        }
        else if mySection == "Products" {
            let cell = tableView.dequeueReusableCellWithIdentifier("LinkCell")
            return cell!
        }
        else if mySection == "Anouncements" {
            let cell = tableView.dequeueReusableCellWithIdentifier("AnouncementCell")
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("NameCell")
            return cell!
        }
    }
    
}