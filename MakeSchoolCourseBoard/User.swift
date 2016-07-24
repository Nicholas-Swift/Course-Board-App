//
//  User.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/15/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation

class User {
    
    var id: String!
    
    var createdAt: String!
    var updatedAt: String!
    
    var email: String!

    var first: String!
    var last: String!
    var fullname: String!
    var username: String!
    
    var role: String!
    
    var courses: [String]!
    var products: [String]!
    var posts: [String]!
    
    var admin: Bool = false
    
    /*, confirmedAt        : { type: Date, default: undefined }
    , resetPasswordToken : String
    , resetPasswordExp   : Date*/
}