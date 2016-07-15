//
//  User.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/15/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation

class User {
    
    var createdAt: String!
    var updatedAt: String!
    
    var email: String!
    var password: String!
    
    var first: String!
    var last: String!
    var username: String!
    var role: String!
    
    var courses: [Course]!
    var products: [Product]!
    
    var admin: Bool = false
    
    /*, confirmedAt        : { type: Date, default: undefined }
    , resetPasswordToken : String
    , resetPasswordExp   : Date*/
}