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
    
    // Variables
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var postBarButton: UIBarButtonItem!
    
    @IBOutlet weak var courseField: UITextField!
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var bodyText: UITextView!
    var bodyDefaultText = true
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textViewConstraint: NSLayoutConstraint!
    
    
    var course: Course!
    
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
        let body = bodyText.text ?? ""
        
        if course == "" && (body == "" || body == "Enter text here...") {
            let alert = UIAlertController(title: "Missing Fields", message: "Please pick a course to post to and add a message to post", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if course == "" {
            let alert = UIAlertController(title: "Missing Field", message: "Please pick a course to post to", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        if (body == "" || body == "Enter text here...") {
            let alert = UIAlertController(title: "Missing Field", message: "Please add a message to your post", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
//        JSONHelper.newPost((courseId: course, body: body)) { (bool, error) in
//            print("DONE")
//            UpdateHelper.boardUpdated = false
//            self.navigationController?.popViewControllerAnimated(true)
//        }
        
        let alert = UIAlertController(title: "Create a new post?", message: nil, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Destructive) {
            UIAlertAction in
        }
        let okAction = UIAlertAction(title: "OK", style: .Default) {
            UIAlertAction in
            
            JSONHelper.newPost((courseId: course, body: body)) { (bool, error) in
                UpdateHelper.boardUpdated = false
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load courses
        load()
        
        // Set up body text
        setupBodyDefaultText(bodyDefaultText)
        
        // If came from post, set it up automatically
        if course != nil {
            courseField.text = course.title
            selectedCourse = course.id
        }
        
        bodyText.delegate = self
        
        courseField.delegate = self
        courseField.inputView = pickerView
        
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func load() {
        
        // Set up courses
        JSONHelper.getAllCourses { (courses, error) in
            self.courses = courses!
            self.pickerView.reloadAllComponents()
        }
        
        // Set up image
        profilePic.layer.cornerRadius = 5
        profilePic.layer.masksToBounds = true
        
        FirebaseHelper.getPicUrl(LoginHelper.id) { (url, error) in
            
            if error == nil {
                self.profilePic.af_setImageWithURL(NSURL(string: url!)!)
            }
        }
        
        // Set up username
        username.text = LoginHelper.fullname
    }
    
    func setupBodyDefaultText(myBool: Bool) {
        
        if myBool == true {
            bodyText.text = "Enter text here..."
            bodyText.textColor = UIColor.darkGrayColor()
        }
        else {
            bodyText.text = ""
            bodyText.textColor = UIColor.blackColor()
        }
        
    }
    
    // For keyboard animations
    
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
        
        bottomConstraint.constant = CGRectGetMaxY(view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame)
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .BeginFromCurrentState, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
}

extension NewPostViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        pickerView.reloadAllComponents()
        if courses.count >= 0 {
            courseField.text = courses[0].title
            selectedCourse = courses[0].id
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
        textField.layoutIfNeeded()
    }
    
    
}

extension NewPostViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        if bodyDefaultText == true {
            bodyDefaultText = false
            setupBodyDefaultText(bodyDefaultText)
        }
        else if bodyText.text == "" {
            bodyDefaultText = true
            setupBodyDefaultText(bodyDefaultText)
        }
        
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        if bodyDefaultText == true {
            bodyDefaultText = false
            setupBodyDefaultText(bodyDefaultText)
        }
        else if bodyText.text == "" {
            bodyDefaultText = true
            setupBodyDefaultText(bodyDefaultText)
        }
        
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
        courseField.text = courses[row].title
        selectedCourse = courses[row].id
    }
    
}