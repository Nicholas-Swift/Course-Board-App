//
//  NewCourse.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/23/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class NewCourseViewController: UITableViewController {
    
    // Variables
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var instructorLabel: UILabel!
    @IBOutlet weak var instructorField: UITextField!
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startDateField: UITextField!
    
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endDateField: UITextField!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var hoursField: UITextField!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var objectivesLabel: UILabel!
    @IBOutlet weak var objectivesLabel2: UILabel!
    
    @IBOutlet weak var objective9Field: UITextField!
    @IBOutlet weak var objective9Remove: UIButton!
    
    @IBOutlet weak var objective10Field: UITextField!
    @IBOutlet weak var objective10Remove: UIButton!
    
    @IBOutlet weak var objective11Field: UITextField!
    @IBOutlet weak var objective11Remove: UIButton!
    
    @IBOutlet weak var objective12Field: UITextField!
    @IBOutlet weak var objective12Remove: UIButton!
    
    @IBOutlet weak var objective13Field: UITextField!
    @IBOutlet weak var objective13Remove: UIButton!
    
    @IBOutlet weak var objective14Field: UITextField!
    @IBOutlet weak var objective14Remove: UIButton!
    
    @IBOutlet weak var addObjectiveButton: UIButton!
    
    var show9 = true
    var show10 = true
    var show11 = true
    var show12 = false
    var show13 = false
    var show14 = false
    
    // Actions
    @IBAction func cancelBarAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveBarAction(sender: AnyObject) {
        
        dismissKeyboard()
    }
    
    @IBAction func addObjectiveAction(sender: AnyObject) {
        
        for i in 0...6 {
            if show9 == false { show9 = true; break }
            if show10 == false { show10 = true; break }
            if show11 == false { show11 = true; break }
            if show12 == false { show12 = true; break }
            if show13 == false { show13 = true; break }
            if show14 == false { show14 = true; break }
            
            //print(i)
        }
        
        updateObjectives()
    }
    
    func updateObjectives() {
        let indexPaths: [NSIndexPath] = [
            NSIndexPath(forRow: 0, inSection: 9-1),
            NSIndexPath(forRow: 0, inSection: 10-1),
            NSIndexPath(forRow: 0, inSection: 11-1),
            NSIndexPath(forRow: 0, inSection: 12-1),
            NSIndexPath(forRow: 0, inSection: 13-1),
            NSIndexPath(forRow: 0, inSection: 14-1)
        ]
        tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        tableView.reloadData()
    }
    
    @IBAction func removeObjectiveAction(sender: AnyObject) {
        let button = sender as! UIButton
        
        if button == objective9Remove {
            if show14 && show13 && show12 && show11 {
                objective9Field.text = objective10Field.text
                objective10Field.text = objective11Field.text
                objective11Field.text = objective12Field.text
                objective12Field.text = objective13Field.text
                objective13Field.text = objective14Field.text
                objective14Field.text = ""
                show14 = false
            }
            else if show13 && show12 && show11{
                objective9Field.text = objective10Field.text
                objective10Field.text = objective11Field.text
                objective11Field.text = objective12Field.text
                objective12Field.text = objective13Field.text
                objective13Field.text = ""
                show13 = false
            }
            else if show12 && show11 {
                objective9Field.text = objective10Field.text
                objective10Field.text = objective11Field.text
                objective11Field.text = objective12Field.text
                objective12Field.text = ""
                show12 = false
            }
            else if show11 && show10 {
                objective9Field.text = objective10Field.text
                objective10Field.text = objective11Field.text
                objective11Field.text = ""
                show11 = false
            }
            else if show10 {
                objective9Field.text = objective10Field.text
                objective10Field.text = ""
                show10 = false
            }
            else {
                objective9Field.text = ""
                show9 = false
            }
        }
        else if button == objective10Remove {
            if show14 && show13 && show12 && show11 {
                objective10Field.text = objective11Field.text
                objective11Field.text = objective12Field.text
                objective12Field.text = objective13Field.text
                objective13Field.text = objective14Field.text
                objective14Field.text = ""
                show14 = false
            }
            else if show13 && show12 && show11{
                objective10Field.text = objective11Field.text
                objective11Field.text = objective12Field.text
                objective12Field.text = objective13Field.text
                objective13Field.text = ""
                show13 = false
            }
            else if show12 && show11 {
                objective10Field.text = objective11Field.text
                objective11Field.text = objective12Field.text
                objective12Field.text = ""
                show12 = false
            }
            else if show11 {
                objective10Field.text = objective11Field.text
                objective11Field.text = ""
                show11 = false
            }
            else {
                objective10Field.text = ""
                show10 = false
            }
        }
        else if button == objective11Remove {
            if show14 && show13 && show12 {
                objective11Field.text = objective12Field.text
                objective12Field.text = objective13Field.text
                objective13Field.text = objective14Field.text
                objective14Field.text = ""
                show14 = false
            }
            else if show13 && show12 {
                objective11Field.text = objective12Field.text
                objective12Field.text = objective13Field.text
                objective13Field.text = ""
                show13 = false
            }
            else if show12 {
                objective11Field.text = objective12Field.text
                objective12Field.text = ""
                show12 = false
            }
            else {
                objective11Field.text = ""
                show11 = false
            }
        }
        else if button == objective12Remove {
            if show14 && show13 {
                objective12Field.text = objective13Field.text
                objective13Field.text = objective14Field.text
                objective14Field.text = ""
                show14 = false
            }
            else if show13 {
                objective12Field.text = objective13Field.text
                objective13Field.text = ""
                show13 = false
            }
            else {
                objective12Field.text = ""
                show12 = false
            }
        }
        else if button == objective13Remove {
            
            if show14 {
                // Shift everything down and then remove last
                objective13Field.text = objective14Field.text
                objective14Field.text = ""
                show14 = false
            }
            else {
                objective13Field.text = ""
                show13 = false
            }
        }
        else if button == objective14Remove {
            // Remove last object
            
            objective14Field.text = ""
            show14 = false
        }
        
        updateObjectives()
    }
    
    // View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clearColor()
        
        // Set up description view properly
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1).CGColor
        descriptionTextView.layer.cornerRadius = 5
        
        // For keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewCourseViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Set up height so we can hide some of the objectives
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let section = indexPath.section+1
        
        if section == 15 { // Add more objectives
            return 60
        }
        else if section >= 9 { // Objectives
            
            if section == 9 {
                return show9 ? 60 : 0
            }
            else if section == 10 {
                return show10 ? 60 : 0
            }
            else if section == 11 {
                return show11 ? 60 : 0
            }
            else if section == 12 {
                return show12 ? 60 : 0
            }
            else if section == 13 {
                return show13 ? 60 : 0
            }
            else if section == 14 {
                return show14 ? 60 : 0
            }
            
            return 60
        }
        else if section == 8 { // Objectives header
            return 60
        }
        else if section == 7 { // Description
            return 180
        }
        else if section >= 1 { // Normal fields
            return 100
        }
        else {
            return 10
        }
        
    }
    
    // No headers!
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    // For keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}