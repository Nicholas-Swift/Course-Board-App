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
    
    // For picker view
    var instructors: [User] = []
    var courses: [MiniCourse] = []
    var textFieldSelected = ""
    var pickerView = UIPickerView()
    var selectedInstructor = ""
    var selectedCourse = ""
    
    // Actions
    @IBAction func cancelBarAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveBarAction(sender: AnyObject) {
        
        dismissKeyboard()
        
        productNameLabel.textColor = UIColor.blackColor(); advisorLabel.textColor = UIColor.blackColor(); courseLabel.textColor = UIColor.blackColor(); problemLabel.textColor = UIColor.blackColor();
        
        let name = productNameField.text ?? ""
        let problem = problemField.text ?? ""
        
        var save = true
        
        if name == "" {
            productNameLabel.textColor = UIColor.redColor()
            save = false
        }
        if selectedInstructor == "" {
            advisorLabel.textColor = UIColor.redColor()
            save = false
        }
        if problem == "" {
            problemLabel.textColor = UIColor.redColor()
            save = false
        }
        
        if save == true {
            JSONHelper.addProduct((name: name, instructor: selectedInstructor, course: selectedCourse, problem: problem), complete: { (bool, error) in
                UpdateHelper.productsUpdated = false
                self.navigationController?.popViewControllerAnimated(true)
            })
        }
    }
    
    // View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clearColor()
        
        // Load all instructors and courses you could put the product in...
        load()
        
        // Fill out the pickerview
        advisorField.delegate = self
        courseField.delegate = self
        
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.whiteColor()
        
        advisorField.inputView = pickerView
        courseField.inputView = pickerView
        
        // For keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewProductViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func load() {
        
        JSONHelper.getAllCourses { (courses, error) in
            self.courses = courses!
            self.pickerView.reloadAllComponents()
        }
        
        JSONHelper.getInstructors { (users, error) in
            self.instructors = users
            self.pickerView.reloadAllComponents()
        }
        
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

extension NewProductViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == advisorField {
            textFieldSelected = "advisor"
            pickerView.reloadAllComponents()
        }
        else if textField == courseField {
            textFieldSelected = "course"
            pickerView.reloadAllComponents()
        }
        else {
            textFieldSelected = ""
            pickerView.reloadAllComponents()
        }
        
        return true
    }
    
}

extension NewProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if textFieldSelected == "advisor" {
            return instructors.count
        }
        else if textFieldSelected == "course" {
            return courses.count
        }
        else {
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if textFieldSelected == "advisor" {
            return instructors[row].fullname
        }
        else if textFieldSelected == "course" {
            return courses[row].title
        }
        else {
            return "BUG"
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if textFieldSelected == "advisor" {
            advisorField.text = instructors[row].fullname
            selectedInstructor = instructors[row].id
            print(selectedInstructor)
        }
        else if textFieldSelected == "course" {
            courseField.text = courses[row].title
            selectedCourse = courses[row].id
            print(selectedCourse)
        }
    }
    
}