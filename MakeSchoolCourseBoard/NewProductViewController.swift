//
//  NewProductViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/12/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class NewProductViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the side menu
        MenuViewController.setupViewController(self, menuButton: menuButton)
        
        // Make tap put keyboard down
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewProductViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Make scrollview go up when keyboard is up
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Extra
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func registerKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unregisterKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo!
        let keyboardSize = userInfo.objectForKey(UIKeyboardFrameBeginUserInfoKey)!.CGRectValue.size
        let contentInsets = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        var viewRect = view.frame
        viewRect.size.height -= keyboardSize.height
        /*if CGRectContainsPoint(viewRect, textField.frame.origin) {
            let scrollPoint = CGPointMake(0, textField.frame.origin.y - keyboardSize.height)
            scrollView.setContentOffset(scrollPoint, animated: true)
        }*/
    }
    
    func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsetsZero
        scrollView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
}