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
    
    var refreshControl: UIRefreshControl!
    
    var products: [MiniProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up Nav Bar style
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor.whiteColor()), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(ColorHelper.redditLightGrayColor)
        
        tableView.alpha = 0
        update()
        
        // Pull to refresh to put everything in
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ProductsViewController.refresh), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        
        // Change to not translucent
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = ColorHelper.blueColor
        self.tabBarController?.tabBar.translucent = false
        
        // remove separator color
        tableView.separatorColor = UIColor.clearColor()
    }
    
    func refresh() {
        update()
    }
    
    override func viewWillAppear(animated: Bool) {
        if UpdateHelper.productsUpdated == false {
            update()
            UpdateHelper.productsUpdated = true
        }
        
        // Unhighlight the highlighted cell
        if let selection: NSIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(selection, animated: true)
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        refreshControl.endRefreshing()
    }
    
    func update() {
        // Get courses and fill tableview
        //tableView.alpha = 0
        JSONHelper.getAllProducts({ (products, error) in
            
            // End refreshing
            self.refreshControl.endRefreshing()
            
            if error == nil {
                if let products = products {
                    
                    // Load tableView
                    self.products = products
                    
                    // Animate the tableView in once data is loaded
                    self.tableView.reloadData()
                    UIView.animateWithDuration(0.2, animations: {
                        self.tableView.alpha = 1
                    })
                }
            }
            else {
                UpdateHelper.productsUpdated = false
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        if section == tableView.numberOfSections-1 {
            return 10
        }
        
        return 5
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
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
        return 130
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let product = products[indexPath.section]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell") as! CourseCell
        cell.setupCard()
        cell.courseTitleLabel.text = product.title
        cell.instructorNameLabel.text = product.instructorName
        cell.dateRangeLabel.text = product.info
        cell.contributorLabel.text = String(product.contributorCount) + " contributors"
        
        return cell
    }
}