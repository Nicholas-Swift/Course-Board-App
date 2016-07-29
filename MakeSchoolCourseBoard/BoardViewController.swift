//
//  BoardViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/23/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class BoardViewController: UIViewController {
    
    // Variables
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change to not translucent
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = ColorHelper.blueColor
        self.tabBarController?.tabBar.translucent = false
        
        // Load posts
        update()
        
        // no separator color
        tableView.separatorColor = UIColor.clearColor()
        
        // Let the cells resize to the correct height based on information
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        if UpdateHelper.boardUpdated == false {
            update()
            UpdateHelper.boardUpdated = true
        }
    }
    
    func update() {
        tableView.alpha = 0
        loadPosts()
    }
    
    func loadPosts() {
        
        JSONHelper.getMe { (user, error) in
            
            self.posts = []
            var temp = 0
            for i in user.courses {
                JSONHelper.getCoursePosts(i, complete: { (posts, error) in
                    
                    for post in posts {
                        post.courseName = user.courseNames[temp]
                        self.posts.append(post)
                    }
                    
                    // Loaded the last one, now we can sort and refresh data!
                    if temp == user.courses.count-1 {
                        
                        // Sort
                        self.posts = self.posts.sort({ (post1, post2) -> Bool in
                            
                            let post1num = Double(post1.createdAt.stringByReplacingOccurrencesOfString("-", withString: "").stringByReplacingOccurrencesOfString("T", withString: "").stringByReplacingOccurrencesOfString(":", withString: "").stringByReplacingOccurrencesOfString("Z", withString: ""))
                            
                            let post2num = Double(post2.createdAt.stringByReplacingOccurrencesOfString("-", withString: "").stringByReplacingOccurrencesOfString("T", withString: "").stringByReplacingOccurrencesOfString(":", withString: "").stringByReplacingOccurrencesOfString("Z", withString: ""))
                            
                            if post1num > post2num {
                                return true
                            }
                            else {
                                return false
                            }
                        })
                        
                        // Animate in
                        self.tableView.reloadData()
                        UIView.animateWithDuration(0.2, animations: {
                            self.tableView.alpha = 1
                        })
                    }
                    
                    temp += 1
                })
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Segue, look down in tableView
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // If going to course
        if segue.identifier == "toCourse" {
            let id = sender as! String
            
            let destination = segue.destinationViewController as! CourseViewController
            destination.id = id
            
            print(id)
        }
    }
}

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Set up stylistic properties
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    // Table View Information setting
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! CoursePostCell
        
        cell.titleButton.setTitle(posts[indexPath.section].courseName, forState: .Normal)
        
        cell.titleButton.addTarget(self, action: #selector(BoardViewController.cellCourse), forControlEvents: .TouchUpInside)
        
        cell.infoLabel.text = posts[indexPath.section].body
        cell.footerLabel.text = "Posted by " + posts[indexPath.section].user + " on " + DateHelper.toShortDate(posts[indexPath.section].createdAt)
        
        return cell
    }
    
    func cellCourse(sender: UIButton) {
        //print(sender.titleLabel?.text)
        
        var index = -1
        for i in 0...posts.count-1 {
            if sender.titleLabel?.text == posts[i].courseName {
                index = i
                break
            }
        }
        
        if index >= 0 {
            performSegueWithIdentifier("toCourse", sender: posts[index].course)
        }
    }
}