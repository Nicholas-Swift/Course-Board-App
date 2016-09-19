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
    
    var refreshControl: UIRefreshControl!
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up Nav Bar style
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor.whiteColor()), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(ColorHelper.redditLightGrayColor)
        
        // Let the cells resize to the correct height based on information
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Pull to refresh to put everything in
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(AccountViewController.refresh), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        
        // Change to not translucent
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = ColorHelper.blueColor
        self.tabBarController?.tabBar.translucent = false
        
        // no separator color
        //self.tableView.separatorColor = UIColor.clearColor()
        
        // Update
        tableView.alpha = 0
        update()
    }
    
    func refresh() {
        update()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if UpdateHelper.accountUpdated == false {
            update()
            UpdateHelper.accountUpdated = true
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        refreshControl.endRefreshing()
    }
    
    
    // TO UPDATE!
    func update() {
        // Load account
        loadAccount()
    }
    
    func loadAccount() {
        
        if id == nil || id == "" {
            getSelf()
        }
        else {
            settingsBarButton.enabled = false
            settingsBarButton.image = nil
            getOther()
        }
    }
    
    func getSelf() {
        JSONHelper.getMe { (user, error) in
            
            if error == nil {
                self.user = user
                self.loadInfo()
                
                self.tableView.reloadData()
                UIView.animateWithDuration(0.2, animations: {
                    self.tableView.alpha = 1
                })
            }
            else {
                
            }
            
            // End refreshing
            self.refreshControl.endRefreshing()
        }
    }
    
    func getOther() {
        JSONHelper.getUser(self.id) { (user, error) in
            
            if error == nil {
                self.user = user
                self.loadInfo()
                
                self.tableView.reloadData()
                UIView.animateWithDuration(0.2, animations: {
                    self.tableView.alpha = 1
                })
            }
            else {
                UpdateHelper.accountUpdated = false
            }
            
            // End refreshing
            self.refreshControl.endRefreshing()
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
                let one = headerArray[i]
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
            
        }
            
            // If going to product
        else if segue.identifier == "toProduct" {
            let id = sender as! String
            
            let destination = segue.destinationViewController as! ProductViewController
            destination.id = id
            
        }
    }
    
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return headerArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return headerDict[headerArray[section]]!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerArray[section]
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let title = UILabel()
        title.font = UIFont(name: "Helvetica Neue", size: 12)!
        title.textColor = UIColor.lightGrayColor()
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CourseHeaderCell
//        
//        cell.headerTitleLabel.text = headerArray[section]
//        
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Set up the info cell
        
        if indexPath.section == 0 {
            
            var idStr = "testCell2"
            
            if id == nil || id == "" {
                idStr = "testCell"
            }
            
            let cell = tableView.dequeueReusableCellWithIdentifier(idStr) as! AccountInfoCell
            
            if id == nil || id == "" {
                cell.setup(LoginHelper.id)
            }
            else {
                cell.setup(user.id)
            }
            
            cell.fullnameLabel.text = user.fullname ?? ""
            cell.usernameLabel.text = user.username ?? ""
            
            if id == nil || id == "" {
                cell.emailLabel.text = user.email ?? ""
            }
            
            return cell
        }
        
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
            //print("Segue to \(user.courses[index]) ... \(user.courseNames[index])")
            
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
            //print("Segue to \(user.products[index]) ... \(user.productNames[index])")
            
            performSegueWithIdentifier("toProduct", sender: user.products[index]) // Segue to account
        }
    }
}