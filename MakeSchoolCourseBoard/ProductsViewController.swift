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
                self.products = products
                self.tableView.reloadData()
            }
        })
        
        // Change to not translucent
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = ColorHelper.blueColor
        self.tabBarController?.tabBar.translucent = false
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
        
        let destination = segue.destinationViewController as! ProductViewController
        
        let indexPath = tableView.indexPathForSelectedRow
        let product = products[indexPath!.row]
        
        destination.product = product
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let product = products[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell") as! CourseCell
        cell.courseTitleLabel.text = product.name
        cell.instructorNameLabel.text = product.instructor
        cell.dateRangeLabel.text = product.problem
        
        return cell
    }
}