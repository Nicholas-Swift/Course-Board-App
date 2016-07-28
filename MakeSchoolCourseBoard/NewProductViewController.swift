//
//  NewProductViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/23/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class NewProductViewController: UITableViewController {
    
    // Variables
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var advisorLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var problemLabel: UILabel!
    
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var advisorField: UITextField!
    @IBOutlet weak var courseField: UITextField!
    @IBOutlet weak var problemField: UITextField!
    
    // Actions
    @IBAction func cancelBarAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveBarAction(sender: AnyObject) {
        
        dismissKeyboard()
        
        productNameLabel.textColor = UIColor.blackColor(); advisorLabel.textColor = UIColor.blackColor(); courseLabel.textColor = UIColor.blackColor(); problemLabel.textColor = UIColor.blackColor();
        
        let name = productNameField.text
        let instructor = advisorField.text
        let course = courseField.text
        let problem = problemField.text
        
        var save = true
        
        if name == "" {
            productNameLabel.textColor = UIColor.redColor()
            save = false
        }
        if instructor == "" {
            advisorLabel.textColor = UIColor.redColor()
            save = false
        }
        if course == "" {
            courseLabel.textColor = UIColor.redColor()
            save = false
        }
        if problem == "" {
            problemLabel.textColor = UIColor.redColor()
            save = false
        }
        
        if save == true {
            JSONHelper.addProduct((name: name!, instructor: instructor!, course: course!, problem: problem!), complete: { (bool, error) in
                UpdateHelper.coursesUpdated = false
                self.navigationController?.popViewControllerAnimated(true)
            })
        }
    }
    
    // View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clearColor()
        
        // For keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewProductViewController.dismissKeyboard))
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