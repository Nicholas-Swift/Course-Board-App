//
//  SettingsViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/12/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UITableViewController {
    
    var user: User!
    
    let headerArray = ["Account Settings"]
    let headerDict = ["Account Settings": 5]
    let labelArray = ["First Name", "Last Name", "Username", "Email", "Role"]
    
    // Variables
    
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    // Actions
    @IBAction func cancelBarAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveBarAction(sender: AnyObject) {
        // Need to get all the information and fill out the tuple
        
        var tempArray: [String] = []
        for i in 0...labelArray.count-1 {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as! AccountFieldCell
            tempArray.append(cell.infoField.text ?? "")
        }
        
        JSONHelper.updateUser((first: tempArray[0], last: tempArray[1], username: tempArray[2], email: tempArray[3], role: tempArray[4])) { (bool, error) in
            print("Updated user")
        }
        
    }
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change separator color to clear
        tableView.separatorColor = UIColor.clearColor()
        
        // Change tint color
        self.navigationController?.navigationBar.translucent = false
        self.tabBarController?.tabBar.translucent = false
        
        // Let the cells resize to the correct height based on information
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // For keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // For TableView
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return headerArray.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerDict[headerArray[section]]!
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Set up the header cell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CourseHeaderCell
        
        cell.headerTitleLabel.text = headerArray[section]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Set up the info cell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FieldCell") as! AccountFieldCell
        
        cell.infoLabel.text = labelArray[indexPath.row]
        
        switch indexPath.row {
        case 0: // first name
            if cell.edited == false {
                cell.infoField.text = user.first
            }
        case 1: // last name
            if cell.edited == false {
                cell.infoField.text = user.last
            }
        case 2: // username
            if cell.edited == false {
                cell.infoField.text = user.username
            }
        case 3: // email
            if cell.edited == false {
                cell.infoField.text = user.email
            }
        case 4: //role
            if cell.edited == false {
                cell.infoField.text = user.role
            }
        default:
            break
        }
        
        return cell
    }
    
    // For keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}