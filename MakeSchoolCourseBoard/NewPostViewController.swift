//
//  NewPostViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 8/2/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class NewPostViewController: UIViewController {
    
    // For animation
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    
    // Variables
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var postBarButton: UIBarButtonItem!
    
    @IBOutlet weak var toCourseField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    
    // For picker view
    var courses: [MiniCourse] = []
    var pickerView = UIPickerView()
    var selectedCourse = ""
    
    // Actions
    @IBAction func cancelBarAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func postBarAction(sender: AnyObject) {
        
        let course = selectedCourse ?? ""
        let body = bodyTextField.text ?? ""
        
        if course == "" {
            //throw error
            print("ERROR IN COURSE")
        }
        if body == "" {
            //throw error
            print("ERROR IN BODY")
        }
        
        print(course)
        print(body)
        
        JSONHelper.newPost((courseId: course, body: body)) { (bool, error) in
            print("DONE")
            UpdateHelper.boardUpdated = false
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    // View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load courses
        load()
        
        // To Course Field
        toCourseField.delegate = self
        toCourseField.layer.cornerRadius = 0
        
        // Set up pickerview
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.whiteColor()
        
        toCourseField.inputView = pickerView
        
        // For keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func load() {
        JSONHelper.getAllCourses({ (courses, error) in
            self.courses = courses!
            self.pickerView.reloadAllComponents()
        })
    }
    
    // For keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // For Animations
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LogInViewController.keyboardWillShowNotification(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LogInViewController.keyboardWillHideNotification(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShowNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification)
    }
    
    func keyboardWillHideNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification)
    }
    
    
    // MARK: - Private
    
    func updateBottomLayoutConstraintWithNotification(notification: NSNotification) {
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view.window)
        //let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedIntValue << 16
        //let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
        
        bottomLayoutConstraint.constant = CGRectGetMaxY(view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame)
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .BeginFromCurrentState, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
}

extension NewPostViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        pickerView.reloadAllComponents()
        
        return true
    }
    
}

extension NewPostViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return courses.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return courses[row].title
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        toCourseField.text = "     " + courses[row].title
        // SET UP THE ID
        selectedCourse = courses[row].id
    }
    
}