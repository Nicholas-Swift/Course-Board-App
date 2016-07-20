//
//  Product.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/13/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation

class Product {
    
    var id: String!
    
    var createdAt: String!
    var updatedAt: String!
    
    var name: String!
    var instructor: String!
    var course: String!
    var problem: String!
    
    var valueProp: String!
    var githubUrl: String!
    var agileUrl: String!
    var liveurl: String!

    var objectives: [String]!
    var posts: [String]!

    var customer: String!
    var assumptions: String!
    var finishedProduct: String!
    var mvp: String!

    var contributors: [String]!
}