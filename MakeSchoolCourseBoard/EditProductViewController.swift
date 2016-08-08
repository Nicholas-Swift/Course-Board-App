//
//  EditProductViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/29/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class EditProductViewController: UITableViewController {
    
    // Variables
    var product: Product!
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productNameField: UITextField!
    
    @IBOutlet weak var advisorLabel: UILabel!
    @IBOutlet weak var advisorField: UITextField!
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var courseField: UITextField!
    
    @IBOutlet weak var problemLabel: UILabel!
    @IBOutlet weak var problemField: UITextField!
    
    @IBOutlet weak var githubLabel: UILabel!
    @IBOutlet weak var githubField: UITextField!
    
    @IBOutlet weak var agileLabel: UILabel!
    @IBOutlet weak var agileField: UITextField!
    
    @IBOutlet weak var liveLabel: UILabel!
    @IBOutlet weak var liveField: UITextField!
    
    @IBOutlet weak var valuePropLabel: UILabel!
    @IBOutlet weak var valuePropField: UITextView!
    
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var customerField: UITextView!
    
    @IBOutlet weak var assumptionsLabel: UILabel!
    @IBOutlet weak var assumptionsField: UITextView!
    
    @IBOutlet weak var finishedProductLabel: UILabel!
    @IBOutlet weak var finishedProductField: UITextView!
    
    @IBOutlet weak var mvpLabel: UILabel!
    @IBOutlet weak var mvpField: UITextView!
    
    @IBOutlet weak var deleteProductButton: UIButton!
    
    // For picker view
    var instructors: [User] = []
    var courses: [MiniCourse] = []
    var textFieldSelected = ""
    var pickerView = UIPickerView()
    var selectedInstructor = ""
    var selectedCourse = ""
    
    // Actions
    @IBAction func deleteProductAction(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Delete Product", message: "Are you sure you want to delete " + product.name + "?", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            //print("Cancel!")
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
            UIAlertAction in
            
            JSONHelper.deleteProduct(self.product.id) { (bool, error) in
                //print("DELETED PRODUCT")
                UpdateHelper.productsUpdated = false
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        }
        
        alert.addAction(okAction)
        alert.addAction(deleteAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelBarAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveBarAction(sender: AnyObject) {
        
        dismissKeyboard()
        
        let name = productNameField.text ?? ""
        let advisor = selectedInstructor
        let course = selectedCourse
        let problem = problemField.text ?? ""
        let github = githubField.text ?? ""
        let agile = agileField.text ?? ""
        let live = liveField.text ?? ""
        let valueProp = valuePropField.text ?? ""
        let customer = customerField.text ?? ""
        let assumption = assumptionsField.text ?? ""
        let finishedProduct = finishedProductField.text ?? ""
        let mvp = mvpField.text ?? ""
        
        var update = true
        
        productNameLabel.textColor = UIColor.blackColor(); advisorLabel.textColor = UIColor.blackColor(); courseLabel.textColor = UIColor.blackColor(); problemLabel.textColor = UIColor.blackColor();
        
        if name == "" {
            productNameLabel.textColor = UIColor.redColor()
            update = false
        }
        if advisor == "" {
            advisorLabel.textColor = UIColor.redColor()
            update = false
        }
        if course == "" {
            courseLabel.textColor = UIColor.redColor()
            update = false
        }
        if problem == "" {
            problemLabel.textColor = UIColor.redColor()
            update = false
        }
        
        if update {
            JSONHelper.editProduct((id: product.id, name: name, advisor: advisor, course: course, problem: problem, github: github, agile: agile, live: live, valueProp: valueProp, customer: customer, assumption: assumption, finishedProduct: finishedProduct, mvp: mvp), complete: { (bool, error) in
                self.navigationController?.popViewControllerAnimated(true)
            })
        }
    }
    
    // View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clearColor()
        
        // Load the correct information
        load()
        
        // Fill out the pickerview
        advisorField.delegate = self
        courseField.delegate = self
        
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.whiteColor()
        
        advisorField.inputView = pickerView
        courseField.inputView = pickerView
        
        // Set up description view properly
        valuePropField.layer.borderWidth = 0.5
        valuePropField.layer.borderColor = UIColor(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).CGColor
        valuePropField.layer.cornerRadius = 5
        
        // Set up description view properly
        customerField.layer.borderWidth = 0.5
        customerField.layer.borderColor = UIColor(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).CGColor
        customerField.layer.cornerRadius = 5
        
        // Set up description view properly
        assumptionsField.layer.borderWidth = 0.5
        assumptionsField.layer.borderColor = UIColor(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).CGColor
        assumptionsField.layer.cornerRadius = 5
        
        // Set up description view properly
        finishedProductField.layer.borderWidth = 0.5
        finishedProductField.layer.borderColor = UIColor(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).CGColor
        finishedProductField.layer.cornerRadius = 5
        
        // Set up description view properly
        mvpField.layer.borderWidth = 0.5
        mvpField.layer.borderColor = UIColor(red: 201/255, green: 201/255, blue: 201/255, alpha: 1).CGColor
        mvpField.layer.cornerRadius = 5
        
        // Set up delete product
        deleteProductButton.layer.cornerRadius = 5
        
        // Let the cells resize to the correct height based on information
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // For keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func load() {
        productNameField.text = product.name ?? ""
        advisorField.text = product.instructorName
        courseField.text = product.course ?? ""
        problemField.text = product.problem ?? ""
        githubField.text = product.githubUrl ?? ""
        agileField.text = product.agileUrl ?? ""
        liveField.text = product.liveurl ?? ""
        valuePropField.text = product.valueProp ?? ""
        customerField.text = product.customer ?? ""
        assumptionsField.text = product.assumptions ?? ""
        finishedProductField.text = product.finishedProduct ?? ""
        mvpField.text = product.mvp ?? ""
        
        JSONHelper.getAllCourses { (courses, error) in
            self.courses = courses!
            self.pickerView.reloadAllComponents()
        }
        
        JSONHelper.getInstructors { (users, error) in
            self.instructors = users
            self.pickerView.reloadAllComponents()
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

extension EditProductViewController: UITextFieldDelegate {
    
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

extension EditProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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