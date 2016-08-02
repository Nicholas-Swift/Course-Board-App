//
//  CourseCell.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/13/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {
    
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var instructorNameLabel: UILabel!
    @IBOutlet weak var dateRangeLabel: UILabel!
    @IBOutlet weak var contributorLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    
    func setupCard() {
        cardView.layer.cornerRadius = 3
        
        cardView.layer.shadowOffset = CGSizeMake(0.2, 0.2)
        cardView.layer.shadowRadius = 2
        cardView.layer.shadowOpacity = 0.2
    }
    
}