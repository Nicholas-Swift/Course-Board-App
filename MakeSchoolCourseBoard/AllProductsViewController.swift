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
}