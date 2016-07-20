//
//  Course.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/13/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation

class Course {
    
    var id: String!
    
    var createdAt: String!
    var updatedAt: String!
    
    var user: String!
    var duration: String!
    
    var instructor: String!
    var title: String!
    var description: String!
    
    var startsOn: String!
    var endsOn: String!
    var hours: String!
    
    var location: String!
    
    var objectives: [String]! // NOTE: Anything that should be an object, holds an ID to it instead!!
    var students: [String]!
    var posts: [String]!
    var products: [String]!
}