//
//  CoursePostCell.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/21/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class CoursePostCell: UITableViewCell {
    
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var footerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    func setupCard() {
        
        // Set up card background
        cardView.layer.cornerRadius = 3
        
        cardView.layer.shadowOffset = CGSizeMake(0.2, 0.2)
        cardView.layer.shadowRadius = 2
        cardView.layer.shadowOpacity = 0.2
    }
    
    func setupProfile(id: String) {
        // Set up image
        profileImageView.layer.cornerRadius = 5
        profileImageView.layer.masksToBounds = true
        
//        FirebaseHelper.getProfilePic(id) { (image, error) in
//            if image != nil {
//                self.profileImageView.image = image!
//            }
//        }
    }
    
}