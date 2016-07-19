//
//  AllProductsViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/12/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class AllProductsViewController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var products: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // For ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JSONHelper.getProducts { (products, error) in
            if let products = products {
                self.products = products
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        // Set up the menu
        MenuViewController.setupViewController(self, menuButton: menuButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // For TableView
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let product = products[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell") as! ProductCell
        cell.nameLabel.text = product.name
        cell.instructorLabel.text = product.instructor
        cell.problemLabel.text = product.problem
        
        return cell
    }
    
    // For Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! ProductViewController
        
        let indexPath = tableView.indexPathForSelectedRow
        let product = products[indexPath!.row]
        
        let dictionary: [String: [String]!] = ["What problem are you solving?": [product.problem], "Objectives": [product.valueProp], "Advisor": [product.instructor], "Course": [product.course], "Contributors": product.contributors, "External Links": [product.githubUrl, product.agileUrl, product.lvieurl]]
        let array: [String] = ["What problem are you solving?", "Objectives", "Advisor", "Course", "Contributors", "External Links"]
        
        destination.title = product.name
        destination.dictionary = dictionary
        destination.array = array
    }
}