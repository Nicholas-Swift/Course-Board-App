//
//  Course.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/13/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Course {
    
    var createdAt: String!
    var updatedAt: String!
    
    var title: String!
    var description: String!
    var instructor: String!
    var duration: String!
    
    var startsOn: String!
    var startsOnDay: String!
    var startsOnMonth: String!
    var startsOnYear: String!
    func startsOnFunc() {
        // Do stuff
    }
    
    var endsOn: String!
    var endsOnDay: String!
    var endsOnMonth: String!
    var endsOnYear: String!
    func endsOnFunc() {
        // Do stuff
    }
    
    var hours: String!
    var location: String!
    var objectives: [String]!
    
    var posts: [String]!
    
    // FOR SEGUEING VIEWS!!!
    var segueDictionary: [String: [String]!]!
    var segueArray: [String]!
    
    /*, user          : { type: Schema.Types.ObjectId, ref: 'User', required: true }
    , instructor    : { type: Schema.Types.ObjectId, ref: 'User', required: true }
    , students      : [{ type: Schema.Types.ObjectId, ref: 'User' }]
    , posts         : [{ type: Schema.Types.ObjectId, ref: 'Post' }]
    , products      : [{ type: Schema.Types.ObjectId, ref: 'Product' }]*/
}