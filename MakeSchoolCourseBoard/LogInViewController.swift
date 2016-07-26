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
    
    // Outlets
    
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var pleaseLogInLabel: UILabel!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var wrongPasswordLabel: UILabel!
    
    @IBOutlet weak var noAccountLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    // Actions
    @IBAction func logInAction(sender: AnyObject) {
        // Log In
        
        logInButton.enabled = false
        
        view.endEditing(true)
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        UIView.animateWithDuration(0.2) { 
            self.wrongPasswordLabel.alpha = 0
        }
        
        LoginHelper.login(username, password: password) { (success, error) in
            
            if success {
                // Success! Go to next view
                self.performSegueWithIdentifier("LogInSegue", sender: self)
            }
            else {
                // Failed
                self.logInButton.enabled = true
                
                if error != nil {
                    // Failed with error! Change text
                    //self.wrongPasswordLabel.text = "An error occured. Are you connected to the internet?"
                }
                
                UIView.animateWithDuration(1.0, animations: { 
                    self.wrongPasswordLabel.alpha = 1.0
                })
                
            }
        }
    }
    
    @IBAction func signUpAction(sender: AnyObject) {
        // Sign Up
    }
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial animations
        mainTitleLabel.alpha = 0
        pleaseLogInLabel.alpha = 0
        
        usernameField.alpha = 0
        passwordField.alpha = 0
        
        logInButton.alpha = 0
        wrongPasswordLabel.alpha = 0
        
        noAccountLabel.alpha = 0 // Don't enable sign up from app
        signUpButton.alpha = 0
        signUpButton.enabled = false
        
        UIView.animateWithDuration(0.5, animations: {
            
            self.mainTitleLabel.alpha = 1
            self.pleaseLogInLabel.alpha = 1
            
            self.usernameField.alpha = 1
            self.passwordField.alpha = 1
            
            self.logInButton.alpha = 1
            self.wrongPasswordLabel.alpha = 0 // keep wrong password hidden
            
            //self.noAccountLabel.alpha = 1 // Don't enable sign up from app
            //self.signUpButton.alpha = 1
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
}