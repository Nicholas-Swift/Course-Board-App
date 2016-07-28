//
//  SettingsViewController2.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/27/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UITableViewController {
    
    // Variables
    
    var user: User!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var roleField: UITextField!
    
    // Actions
    @IBAction func cancelBarAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveBarAction(sender: AnyObject) {
        
        dismissKeyboard()
        
        let first = firstNameField.text
        let last = lastNameField.text
        let username = userNameField.text
        let email = emailField.text
        let role = roleField.text
        
        // Check to see if the fields have good information
        var update = true
        
        let tempArray = [first, last, username, email, role]
        let tempArray2 = [firstNameLabel, lastNameLabel, userNameLabel, emailLabel, roleLabel]
        for i in 0...tempArray.count-1 { // if anything is empty
            if tempArray[i] == "" {
                update = false
                tempArray2[i].textColor = UIColor.redColor()
            }
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}" // check if valid email
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        //print(emailTest.evaluateWithObject(email))
        if emailTest.evaluateWithObject(email) == false {
            update = false
            emailLabel.textColor = UIColor.redColor()
        }
        
        if role != "Student" && role != "Instructor" && role != "Staff" { // check if valid role
            update = false
            roleLabel.textColor = UIColor.redColor()
        }
        
        if update == true {
            UpdateHelper.accountUpdated = false
            
            JSONHelper.updateUser((first: first!, last: last!, username: username!, email: email!, role: role!)) { (bool, error) in
                self.navigationController?.popViewControllerAnimated(true)
            }
            
        }
    }
    
    // View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clearColor()
        
        // Fill out the fields
        firstNameField.text = user.first ?? ""
        lastNameField.text = user.last ?? ""
        userNameField.text = user.username ?? ""
        emailField.text = user.email ?? ""
        roleField.text = user.role ?? ""
        
        // For keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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