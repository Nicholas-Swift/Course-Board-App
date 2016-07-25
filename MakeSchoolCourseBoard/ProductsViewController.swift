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
    
    var products: [MiniProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get courses and fill tableview
        tableView.alpha = 0
        JSONHelper.getAllProducts({ (products, error) in
            if let products = products {
                
                // Load tableView
                self.products = products
                
                // Animate the tableView in once data is loaded
                self.tableView.reloadData()
                UIView.animateWithDuration(0.2, animations: {
                    self.tableView.alpha = 1
                })
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
            
            destination.id = product.id
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
        cell.courseTitleLabel.text = product.title
        cell.instructorNameLabel.text = product.instructorName
        cell.dateRangeLabel.text = product.info
        
        return cell
    }
}