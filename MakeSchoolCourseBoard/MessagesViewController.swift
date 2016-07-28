//
//  MessagesViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/26/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class MessagesViewController: ViewController {
    
    // Variables
    
    @IBOutlet weak var tableView: UITableView!
    
    // General View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change to not translucent
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = ColorHelper.blueColor
        self.tabBarController?.tabBar.translucent = false
        
        // no separator color
        //tableView.separatorColor = UIColor.clearColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        // Update
        if UpdateHelper.messagesUpdated == false {
            update()
            UpdateHelper.messagesUpdated = true
        }
        
        // Unhighlight the highlighted cell
        if let selection: NSIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(selection, animated: true)
        }
    }
    
    func update() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MessagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return("Recent Messages")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell")
        return cell!
    }
    
}