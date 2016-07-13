//
//  JSONHelper.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/13/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class JSONHelper {
    
    // Get all courses
    static func getCourses(complete:
        ( courses: [Course]?, error: NSError?) -> Void)
    {
        
        // Call the api
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
                        course.instructor = json[i]["instructor"]["fullname"].stringValue
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
                        course.objectives = json[i]["objectives"].stringValue.componentsSeparatedByString(",")
                        
                        course.posts = json[i]["posts"].stringValue.componentsSeparatedByString(",")
                        
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
                        
                        //product.course = String!
                        product.instructor = json[i]["instructor"]["fullname"].stringValue
                        //product.contributors = String!
                        
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
    
}