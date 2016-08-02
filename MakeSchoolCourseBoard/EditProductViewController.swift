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
    
    @IBOutlet weak var deleteProductButton: UIButton!
    
    // Actions
    @IBAction func deleteProductAction(sender: AnyObject) {
        JSONHelper.deleteProduct(product.id) { (bool, error) in
            print("DELETED PRODUCT")
            UpdateHelper.productsUpdated = false
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    @IBAction func cancelBarAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveBarAction(sender: AnyObject) {
        
        dismissKeyboard()
        
        let name = productNameField.text ?? ""
        let advisor = advisorField.text ?? ""
        let course = courseField.text ?? ""
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