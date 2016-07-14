//
//  Product.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/13/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation

class Product {
    
    var createdAt: String!
    var updatedAt: String!
    
    var name: String!
    var problem: String!
    var githubUrl: String!
    var agileUrl: String!
    var lvieurl: String!
    var valueProp: String!
    var customer: String!
    var assumptions: String!
    var finishedProduct: String!
    var mvp: String!
    
    var course: String!
    var instructor: String!
    var contributors: [String]!
    
    // , posts         : [{ type: Schema.Types.ObjectId, ref: 'Post' }]
}