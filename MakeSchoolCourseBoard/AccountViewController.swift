//
//  AccountViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/12/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class AccountViewController: UIViewController {
    
    // Variables
    @IBOutlet weak var tableView: UITableView!
    
    let headerArray = ["Account Information", "Courses", "Products", "Anouncements"]
    var headerDict = ["Account Information": 0, "Courses": 0, "Products": 0, "Anouncements": 0]
    var user = User()
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Let the cells resize to the correct height based on information
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Change to not translucent
        self.navigationController?.navigationBar.translucent = false
        self.tabBarController?.tabBar.translucent = false
        
        self.tableView.separatorColor = UIColor.clearColor()
        
        JSONHelper.getMe { (user, error) in
            self.user = user
            
            self.headerDict["Account Information"] = 3 // Name, username, email
            self.headerDict["Courses"] = user.courses.count
            self.headerDict["Products"] = user.products.count
            self.headerDict["Anouncements"] = user.posts.count ?? 0
            
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return headerArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerDict[headerArray[section]]!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CourseHeaderCell
        
        cell.headerTitleLabel.text = headerArray[section]
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Set up the info cell
        
        let mySection = headerArray[indexPath.section]
        
        if mySection == "Account Information" {
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            cell.infoLabel.text = ""
            
            switch(indexPath.row) {
            case 0:
                cell.infoLabel.text = user.fullname
            case 1:
                cell.infoLabel.text = user.username
            case 2:
                cell.infoLabel.text = user.email
            default:
                break
            }
            
            return cell
        }
        else if mySection == "Courses" {
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(user.courses[indexPath.row] ?? "", forState: .Normal)
            
            return cell
        }
        else if mySection == "Products" {
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
            
            cell.infoButton.setTitle(user.courses[indexPath.row] ?? "", forState: .Normal)
            
            return cell
        }
        else if mySection == "Anouncements" {
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            cell.infoLabel.text = "anouncement here here here here"
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell") as! CourseTextCell
            
            cell.infoLabel.text = "DEFAULT BROOOO!"
            
            return cell
        }
    }
}