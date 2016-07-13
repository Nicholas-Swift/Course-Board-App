//
//  MenuProfileCell.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/12/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class MenuProfileCell: UITableViewCell {
    
    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func layoutSubviews() {
        
        // Change image to circle
        profilePictureImage.layer.cornerRadius = profilePictureImage.frame.size.width / 2
        profilePictureImage.clipsToBounds = true
    }
}