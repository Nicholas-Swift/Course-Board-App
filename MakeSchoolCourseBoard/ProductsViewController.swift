//
//  AllProductsViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/12/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class ProductsViewController: UIViewController {
    
    // Variables
    @IBOutlet weak var tableView: UITableView!
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get courses and fill tableview
        JSONHelper.getAllProducts({ (products, error) in
            if let products = products {
                
                // Load tableView
                self.products = products
                
                // Fill out student names
                for i in 0...self.products.count-1 {
                    for j in self.products[i].contributors {
                        JSONHelper.getUser(j, complete: { (user, error) in
                            print(user.fullname)
                            self.products[i].contributorNames.append(user.fullname)
                        })
                    }
                }
                
                self.tableView.reloadData()
            }
        })
        
        // Change to not translucent
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = ColorHelper.blueColor
        self.tabBarController?.tabBar.translucent = false
        
        // remove separator color
        tableView.separatorColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        // Unhighlight the highlighted cell
        if let selection: NSIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(selection, animated: true)
        }
    }
    
    // For Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "viewProduct" {
            let destination = segue.destinationViewController as! ProductViewController
            
            let indexPath = tableView.indexPathForSelectedRow
            let product = products[indexPath!.section]
            
            destination.product = product
        }
        else {
            //let destination = segue.destinationViewController as! NewProductViewController
        }
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // For looks
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    // For information setting
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let product = products[indexPath.section]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell") as! CourseCell
        cell.courseTitleLabel.text = product.name
        cell.instructorNameLabel.text = product.instructorName // product.instructor
        cell.dateRangeLabel.text = product.problem
        
        return cell
    }
}