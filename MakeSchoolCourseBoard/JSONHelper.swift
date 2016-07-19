//
//  JSONHelper.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/13/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

// NEEDS TO BE UPDATED AND STUFF WILDLY!

import Foundation
import Alamofire
import SwiftyJSON

class JSONHelper {
    
    // Get all courses
    static func getAllCourses(complete: ( courses: [Course]?, error: NSError?) -> Void)
    {
        // Url of the api
        let apiToContact = "https://meancourseboard.herokuapp.com/api/courses"
        
        Alamofire.request(.GET, apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    var courses = [Course]()
                    for i in 0...(json.count-1) {
                        //print(json)
                        
                        let course = Course()
                        
                        course.createdAt = json[i]["createdAt"].stringValue
                        course.updatedAt =  json[i]["updatedAt"].stringValue
                        
                        course.title = json[i]["title"].stringValue
                        course.description = json[i]["description"].stringValue
                        course.duration = json[i]["duration"].stringValue
                        
                        course.startsOn = json[i]["startsOn"].stringValue
                        /*course.startsOnDay: String!
                        course.startsOnMonth: String!
                        course.startsOnYear: String!*/
                        
                        course.endsOn = json[i]["endsOn"].stringValue
                        /*course.endsOnDay: String!
                        course.endsOnMonth: String!
                        course.endsOnYear: String!*/
                        
                        course.hours = json[i]["hours"].stringValue
                        course.location = json[i]["location"].stringValue // NO LOCATION YET?
                        course.objectives = json[i]["objectives"].arrayValue.map{$0.string!}
                        
                        //course.user = json[i]["user"]
                        course.instructor = json[i]["instructor"]["fullname"].stringValue
                        //course.students = json[i]["students"]
                        //course.posts = json[i]["posts"]
                        //course.products = json[i]["products"]
                        
                        //course.posts = json[i]["posts"].arrayValue.map{$0.string!}
                        
                        courses.append(course)
                    }
                    
                    complete(courses: courses, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(courses: nil, error: error)
            }
        }
    }
    
    // Get specific course
    static func getCourse(id: String, complete:
        ( course: Course?, error: NSError?) -> Void)
    {
        
        // Call the api
        let apiToContact = "https://meancourseboard.herokuapp.com/api/courses/" + id
        
        Alamofire.request(.GET, apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    let course = Course()
                    
                    course.createdAt = json["createdAt"].stringValue
                    course.updatedAt =  json["updatedAt"].stringValue
                    
                    course.title = json["title"].stringValue
                    course.description = json["description"].stringValue
                    course.duration = json["duration"].stringValue
                    
                    course.startsOn = json["startsOn"].stringValue
                    /*course.startsOnDay: String!
                     course.startsOnMonth: String!
                     course.startsOnYear: String!*/
                    
                    course.endsOn = json["endsOn"].stringValue
                    /*course.endsOnDay: String!
                     course.endsOnMonth: String!
                     course.endsOnYear: String!*/
                    
                    course.hours = json["hours"].stringValue
                    course.location = json["location"].stringValue // NO LOCATION YET?
                    course.objectives = json["objectives"].arrayValue.map{$0.string!}
                    
                    //course.user = json[i]["user"]
                    course.instructor = json["instructor"]["fullname"].stringValue
                    //course.students = json[i]["students"]
                    //course.posts = json[i]["posts"]
                    //course.products = json[i]["products"]
                    
                    //course.posts = json[i]["posts"].arrayValue.map{$0.string!}
                    
                    complete(course: course, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(course: nil, error: error)
            }
        }
    }
    
    // Get all products
    static func getProducts(complete:
        ( products: [Product]?, error: NSError?) -> Void)
    {
        
        // Call the api
        let apiToContact = "https://meancourseboard.herokuapp.com/api/products"
        
        Alamofire.request(.GET, apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    var products = [Product]()
                    
                    for i in 0...(json.count-1) {
                        //print(json)
                        
                        let product = Product()
                        
                        product.name = json[i]["name"].stringValue
                        product.instructor = json[i]["instructor"]["fullname"].stringValue
                        product.problem = json[i]["problem"].stringValue
                        
                        product.createdAt = json[i]["createdAt"].stringValue
                        product.updatedAt = json[i]["updatedAt"].stringValue
                        
                        product.name = json[i]["name"].stringValue
                        product.problem = json[i]["problem"].stringValue
                        product.githubUrl = json[i]["githubUrl"].stringValue
                        product.agileUrl = json[i]["agileUrl"].stringValue
                        product.lvieurl = json[i]["liveUrl"].stringValue
                        product.valueProp = json[i]["valueProp"].stringValue
                        /*product.customer = String!
                        product.assumptions = String!
                        product.finishedProduct = String!
                        product.mvp = String!*/
                        
                        product.course = ""
                        product.instructor = json[i]["instructor"]["fullname"].stringValue
                        product.contributors = json[i]["contributors"].arrayValue.map {$0.string!}
                        
                        products.append(product)
                    }
                    
                    complete(products: products, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(products: nil, error: error)
            }
        }
    }
    
    // Get current user
    static func getCurrentUser(complete: (user: User!, error: NSError?) -> Void) {
        
        // Call the api
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        let apiToContact = "https://meancourseboard.herokuapp.com/api/me"
        
        Alamofire.request(.GET, apiToContact, headers: headers).validate().responseJSON() { response in
            
            // Add the json info to user
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let user = User()
                    
                    //print(json)
                    
                    user.id = json["id"].stringValue
                    if json["admin"] == 0 {
                        user.admin = false
                    }
                    else {
                        user.admin = true
                    }
                    user.first = json["first"].stringValue
                    user.last = json["last"].stringValue
                    user.fullname = json["fullname"].stringValue
                    user.role = json["role"].stringValue
                    user.username = json["username"].stringValue
                    for i in json["courses"].arrayValue {
                        print(i["_id"])
                        JSONHelper.getCourse(i["_id"].stringValue, complete: {
                            (course, error) in
                            user.courses.append(course!)
                            complete(user: user, error: nil)
                        })
                    }
                    /*for i in json["products"].arrayValue {
                        print(i["_id"])
                        JSONHelper.getCourse(i["_id"].stringValue, complete: { (course, error) in
                            user.courses.append(course!)
                        })
                    }*/
                    
                    //complete(user: user, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(user: nil, error: error)
            }
        }
    }
    
}
