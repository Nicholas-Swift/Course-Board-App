//
//  AccountFieldCell.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/22/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class AccountFieldCell: UITableViewCell {
    
    // Variables
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoField: UITextField!
    
    var num: Int!
    
    var edited = false
    
    @IBAction func fieldAction(sender: AnyObject) {
        edited = true
    }
    
}