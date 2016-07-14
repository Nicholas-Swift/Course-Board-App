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
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change separator color to clear
        tableView.separatorColor = UIColor.clearColor()
        tableView.editing = false
        
        // Let the cells resize to the correct height based on information
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // For Menu
        MenuViewController.setupViewController(self, menuButton: menuButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // For TableView
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
        
        var str = "NameCell"
        
        switch indexPath.section {
        case 0:
            str = "NameCell"
        case 1:
            str = "LinkCell"
        case 2:
            str = "Link Cell"
        case 3:
            str = "AnouncementCell"
        default:
            break
        }
        print(str)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(str)
        return cell!
    }
    
}