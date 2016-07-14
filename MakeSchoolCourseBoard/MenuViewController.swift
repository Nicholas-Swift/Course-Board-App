//
//  MenuViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/12/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UITableViewController {
    
    // Extra
    static func setupViewController(controller: UIViewController, menuButton: UIBarButtonItem) {
        controller.revealViewController().bounceBackOnOverdraw = false
        controller.revealViewController().extendsPointInsideHit = false
        if controller.revealViewController() != nil {
            menuButton.target = controller.revealViewController()
            menuButton.action = "revealToggle:"
            controller.view.addGestureRecognizer(controller.revealViewController().panGestureRecognizer())
        }
    }
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorInset.left = 80
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // For TableView
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // If the index path is 0, make it the profile cell, else, it's a menu cell.
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell")
            
            // change name and profile picture image
            
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as! MenuCell
            
            let textArray = ["Courses", "All Products", "New Course", "New Product", "Account", "Settings"]
            
            cell.menuLabel.text = textArray[indexPath.row - 1]
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row != 0 {
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! MenuCell
            let str = cell.menuLabel.text! + "Segue"
            print(str)
            
            performSegueWithIdentifier(str, sender: self)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var num: CGFloat = 60
        if indexPath.row == 0 {
            num = 120
        }
        
        return num
    }
    
}