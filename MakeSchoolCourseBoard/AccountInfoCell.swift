//
//  AccountInfoCell.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 8/4/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class AccountInfoCell: UITableViewCell {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var accountPic: UIImageView!
    @IBOutlet weak var mailPic: UIImageView!
    
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    func setup(id: String) {
        profilePic.layer.cornerRadius = 4
        profilePic.layer.masksToBounds = true

        FirebaseHelper.getPicUrl(id) { (url, error) in
            
            if error == nil {
                //let urlString = url
                //print(urlString!)
                
                self.profilePic.af_setImageWithURL(NSURL(string: url!)!)
            }
        }
    }
    
}