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
    @IBOutlet weak var valuePropField: UITextField!
    
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var customerField: UITextField!
    
    @IBOutlet weak var assumptionsLabel: UILabel!
    @IBOutlet weak var assumptionsField: UITextField!
    
    @IBOutlet weak var finishedProductLabel: UILabel!
    @IBOutlet weak var finishedProductField: UITextField!
    
    @IBOutlet weak var mvpLabel: UILabel!
    @IBOutlet weak var mvpField: UITextField!
    
    // Actions
    @IBAction func cancelBarAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveBarAction(sender: AnyObject) {
        
        dismissKeyboard()
        
        // Save the stuff
    }
    
    // View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clearColor()
        
        // Load the correct information
        load()
        
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
        advisorField.text = product.instructor ?? ""
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