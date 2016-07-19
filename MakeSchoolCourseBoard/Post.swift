//
//  Post.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/15/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

// NEEDS TO BE UPDATED AND STUFF WILDLY!

import Foundation

class Post {
    
    var createdAt: String!
    var updatedAt: String!
    
    var body: String!
    var dueDate: String!
    var emailParticipants: Bool = false
    
    var user: User!
    var course: Course!
}