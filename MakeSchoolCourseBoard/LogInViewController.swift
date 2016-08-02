//
//  LogInViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/21/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class LogInViewController: UIViewController {
    
    // For Animations
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var signUpConstraint: NSLayoutConstraint!
    @IBOutlet weak var logInConstraint: NSLayoutConstraint!
    
    // Outlets
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    // Actions
    @IBAction func logInAction(sender: AnyObject) {
        
        // Log In
        logInButton.enabled = false
        dismissKeyboard()
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        LoginHelper.login(username, password: password) { (success, error) in
            
            if success {
                // Success! Go to next view
                self.performSegueWithIdentifier("LogInSegue", sender: self)
            }
            else {
                // Failed
                self.logInButton.enabled = true
                
                var title = "Incorrect email or password"
                var message = "The email or password you entered is incorrect. Please try again."
                var click = "OK"
                
                if error!.code != -6003 {
                    title = "Cannot connect to server"
                    message = "Make sure you are connected to the internet."
                    click = "OK"
                }
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: click, style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func SignUpAction(sender: AnyObject) {
        
        let title = "To sign up..."
        let message = "Course Board is currently only available to Make School students, instructors, and staff. To create an account please talk to or message your instructor."
        let click = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: click, style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial animations
        usernameField.alpha = 0
        passwordField.alpha = 0
        logInButton.alpha = 0
        
        UIView.animateWithDuration(0.5, animations: {
            self.usernameField.alpha = 1
            self.passwordField.alpha = 1
            
            self.logInButton.alpha = 1
        })
        
        // For keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        signUpConstraint.constant = 5
        logInConstraint.constant = 15
        updateBottomLayoutConstraintWithNotification(notification)
    }
    
    func keyboardWillHideNotification(notification: NSNotification) {
        signUpConstraint.constant = 90
        logInConstraint.constant = 100
        updateBottomLayoutConstraintWithNotification(notification)
    }
    
    
    // MARK: - Private
    
    func updateBottomLayoutConstraintWithNotification(notification: NSNotification) {
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view.window)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedIntValue << 16
        let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
        
        bottomLayoutConstraint.constant = CGRectGetMaxY(view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame)
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .BeginFromCurrentState, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

}