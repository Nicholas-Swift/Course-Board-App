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
    @IBOutlet weak var settingsBarButton: UIBarButtonItem!

    var id: String!
    var user = User()
    
    var headerArray: [String] = []
    var headerDict: [String: Int] = [:]
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Let the cells resize to the correct height based on information
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Change to not translucent
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = ColorHelper.blueColor
        self.tabBarController?.tabBar.translucent = false
        
        self.tableView.separatorColor = UIColor.clearColor()
        
        // Update
        update()
    }
    
    // TO UPDATE!
    func update() {
        // Load account
        tableView.alpha = 0
        loadAccount()
    }
    
    func loadAccount() {
        
        if id == nil || id == "" {
            getSelf()
        }
        else {
            settingsBarButton.enabled = false
            getOther()
        }
    }
    
    func getSelf() {
        JSONHelper.getMe { (user, error) in
            self.user = user
            self.loadInfo()
            
            self.tableView.reloadData()
            UIView.animateWithDuration(0.2, animations: {
                self.tableView.alpha = 1
            })
        }
    }
    
    func getOther() {
        JSONHelper.getUser(self.id) { (user, error) in
            self.user = user
            self.loadInfo()
            
            self.tableView.reloadData()
            UIView.animateWithDuration(0.2, animations: {
                self.tableView.alpha = 1
            })
        }
    }
    
    func loadInfo() {
        headerArray = ["Account Information", "Courses", "Products", "Anouncements"]
        
        // Account Info - name, username, email
        var accountInfoNum = 0
        
        if let _ = user.fullname { accountInfoNum += 1 }
        if let _ = user.username { accountInfoNum += 1 }
        if let _ = user.email { accountInfoNum += 1 }
        
        // Courses
        var coursesNum = 0
        if let _ = user.courses { coursesNum = user.courses.count }
        
        // Products
        var productsNum = 0
        if let _ = user.products { productsNum = user.products.count }
        
        // Anouncements
        var anouncementsNum = 0
        if let _ = user.posts { anouncementsNum = user.posts.count }
        
        // Remove from array and dictionary as needed
        let tempArray = [accountInfoNum, coursesNum, productsNum, anouncementsNum]
        var removeArray: [Int] = []
        
        for i in 0...headerArray.count-1 {
            if tempArray[i] == 0 {
                removeArray.append(i)
            }
            else {
                print(headerArray[i])
                let one = headerArray[i]
                print(tempArray[i])
                let two = tempArray[i]
                
                headerDict[one] = two
            }
        }
        var temp = 0
        for i in removeArray {
            headerArray.removeAtIndex(i - temp)
            temp += 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Segue, look down in tableView
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // If settings
        if segue.identifier == "toSettings" {
            let destination = segue.destinationViewController as! SettingsViewController
            destination.user = self.user
        }
        
        // If going to account
        if segue.identifier == "toCourse" {
            let id = sender as! String
            
            let destination = segue.destinationViewController as! CourseViewController
            destination.id = id
            
            print(id)
        }
            
            // If going to product
        else if segue.identifier == "toProduct" {
            let id = sender as! String
            
            let destination = segue.destinationViewController as! ProductViewController
            destination.id = id
            
            print(id)
        }
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
        return 30
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
            
            cell.infoButton.setTitle(user.courseNames[indexPath.row] ?? "", forState: .Normal)
            
            // Set up the action to go to course
            cell.infoButton.addTarget(self, action: #selector(AccountViewController.cellCourse), forControlEvents: .TouchUpInside)
            
            return cell
        }
        else if mySection == "Products" {
            let cell = tableView.dequeueReusableCellWithIdentifier("ButtonCell") as! CourseButtonCell
        
            cell.infoButton.setTitle(user.productNames[indexPath.row] ?? "", forState: .Normal)
            
            // Set up the action to go to product
            cell.infoButton.addTarget(self, action: #selector(AccountViewController.cellProduct), forControlEvents: .TouchUpInside)
            
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
    
    // For cell button touches
    
    func cellCourse(sender: UIButton) {
        //print(sender.titleLabel?.text)
        
        var index = -1
        for i in 0...user.courseNames.count-1 {
            if sender.titleLabel?.text == user.courseNames[i] {
                index = i
                break
            }
        }
        
        if index >= 0 {
            print("Segue to \(user.courses[index]) ... \(user.courseNames[index])")
            
            performSegueWithIdentifier("toCourse", sender: user.courses[index]) // Segue to account
        }
    }
    
    func cellProduct(sender: UIButton) {
        //print(sender.titleLabel?.text)
        
        var index = -1
        for i in 0...user.productNames.count-1 {
            if sender.titleLabel?.text == user.productNames[i] {
                index = i
                break
            }
        }
        
        if index >= 0 {
            print("Segue to \(user.products[index]) ... \(user.productNames[index])")
            
            performSegueWithIdentifier("toProduct", sender: user.products[index]) // Segue to account
        }
    }
}