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
    
    // MARK: Courses
    
    // Get all courses
    static func getAllCourses(complete: ( courses: [Course]?, error: NSError?) -> Void)
    {
        
        // Url of the api
        let apiToContact = "https://meancourseboard.herokuapp.com/api/courses"
        
        // Set up headers
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        // Request the data from api
        Alamofire.request(.GET, apiToContact, headers: headers).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    // Set up courses array and loop through, adding to it
                    var courses = [Course]()
                    for i in 0...(json.count-1) {
                        //print(json)
                        
                        let course = Course()
                        
                        course.id = json[i]["_id"].stringValue
                        
                        course.createdAt = json[i]["createdAt"].stringValue
                        course.updatedAt = json[i]["updatedAt"].stringValue
                        
                        course.user = json[i]["user"].stringValue // Note, this holds the user id
                        course.duration = json[i]["duration"].stringValue
                        
                        course.instructor = json[i]["instructor"]["_id"].stringValue
                        course.title = json[i]["title"].stringValue
                        course.description = json[i]["description"].stringValue
                        
                        course.startsOn = json[i]["startsOn"].stringValue
                        course.endsOn = json[i]["endsOn"].stringValue
                        course.hours = json[i]["hours"].stringValue
                        
                        course.location = json[i]["location"].stringValue
                        
                        course.objectives = json[i]["objectives"].arrayValue.map{$0.string!}
                        course.students = json[i]["students"].arrayValue.map{$0.string!}
                        course.posts = json[i]["posts"].arrayValue.map{$0.string!}
                        course.products = json[i]["products"].arrayValue.map{$0.string!}
                        
                        courses.append(course)
                    }
                    
                    // Complete and return courses array
                    complete(courses: courses, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(courses: nil, error: error)
            }
        }
    }
    
    // Get specific course
    static func getCourse(id: String, complete: ( course: Course?, error: NSError?) -> Void)
    {
        
        // Call the api
        let apiToContact = "https://meancourseboard.herokuapp.com/api/courses/" + id
        
        // Set up headers
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        // Request the data from api
        Alamofire.request(.GET, apiToContact, headers: headers).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    //print(json)
                    
                    let course = Course()
                    
                    course.id = json["_id"].stringValue
                    
                    course.createdAt = json["createdAt"].stringValue
                    course.updatedAt = json["updatedAt"].stringValue
                    
                    course.user = json["user"].stringValue // Note, this holds the user id
                    course.duration = json["duration"].stringValue
                    
                    course.instructor = json["instructor"]["_id"].stringValue
                    course.title = json["title"].stringValue
                    course.description = json["description"].stringValue
                    
                    course.startsOn = json["startsOn"].stringValue
                    course.endsOn = json["endsOn"].stringValue
                    course.hours = json["hours"].stringValue
                    
                    course.location = json["location"].stringValue
                    
                    course.objectives = json["objectives"].arrayValue.map{$0.string!}
                    course.students = json["students"].arrayValue.map{$0["_id"].stringValue}
                    course.posts = json["posts"].arrayValue.map{$0["_id"].stringValue}
                    course.products = json["products"].arrayValue.map{$0["_id"].stringValue}
                    
                    complete(course: course, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(course: nil, error: error)
            }
        }
    }
    
    // MARK: Products
    
    // Get all products
    static func getAllProducts(complete: ( products: [Product]?, error: NSError?) -> Void)
    {
        
        // Call the api
        let apiToContact = "https://meancourseboard.herokuapp.com/api/products"
        
        // Set up headers
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        // Request the data from api
        Alamofire.request(.GET, apiToContact, headers: headers).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    var products = [Product]()
                    
                    for i in 0...(json.count-1) {
                        //print(json[i])
                        
                        let product = Product()
                        
                        product.id = json[i]["_id"].stringValue
                        
                        product.createdAt = json[i]["createdAt"].stringValue
                        product.updatedAt = json[i]["updatedAt"].stringValue
                        
                        product.name = json[i]["name"].stringValue
                        product.instructor = json[i]["instructor"]["_id"].stringValue
                        product.course = json[i]["course"].stringValue
                        product.problem = json[i]["problem"].stringValue
                        
                        product.valueProp = json[i]["valueProp"].stringValue
                        product.githubUrl = json[i]["githubUrl"].stringValue
                        product.agileUrl = json[i]["agileUrl"].stringValue
                        product.liveurl = json[i]["liveUrl"].stringValue
                        
                        product.objectives = json[i]["objectives"].arrayValue.map{$0.string!}
                        product.posts = json[i]["posts"].arrayValue.map{$0.string!}
                        
                        //product.customer = json[i]["customer"].stringValue //???
                        //product.assumptions = json[i]["assumptions"].stringValue //???
                        //product.finishedProduct = json[i]["finishedProduct"].stringValue //???
                        //product.mvp = json[i]["mvp"].stringValue //???
                        
                        product.contributors = json[i]["contributors"].arrayValue.map{$0.string!}
                        
                        products.append(product)
                    }
                    
                    // complete and return products array
                    complete(products: products, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(products: nil, error: error)
            }
        }
    }
    
    // Get specific product
    static func getProduct(id: String, complete: ( product: Product?, error: NSError?) -> Void)
    {
        
        // Call the api
        let apiToContact = "https://meancourseboard.herokuapp.com/api/products" + id
        
        // Set up headers
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        // Request the data from api
        Alamofire.request(.GET, apiToContact, headers: headers).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    print(json)
                        
                    let product = Product()
                        
                    product.id = json["_id"].stringValue
                        
                    product.createdAt = json["createdAt"].stringValue
                    product.updatedAt = json["updatedAt"].stringValue
                        
                    product.name = json["name"].stringValue
                    product.instructor = json["instructor"]["_id"].stringValue
                    product.course = json["course"].stringValue
                    product.problem = json["problem"].stringValue
                        
                    product.valueProp = json["valueProp"].stringValue
                    product.githubUrl = json["githubUrl"].stringValue
                    product.agileUrl = json["agileUrl"].stringValue
                    product.liveurl = json["liveUrl"].stringValue
                        
                    product.objectives = json["objectives"].arrayValue.map{$0.string!}
                    product.posts = json["posts"].arrayValue.map{$0["_id"].stringValue}
                        
                    //product.customer = json["customer"].stringValue //???
                    //product.assumptions = json["assumptions"].stringValue //???
                    //product.finishedProduct = json["finishedProduct"].stringValue //???
                    //product.mvp = json["mvp"].stringValue //???
                        
                    product.contributors = json["contributors"].arrayValue.map{$0["_id"].stringValue}
                    
                    // complete and return product
                    complete(product: product, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(product: nil, error: error)
            }
        }
    }
    
    // MARK: Users
    
    // Get me
    static func getMe(complete: (user: User!, error: NSError?) -> Void) {
        
        // Call the api
        let apiToContact = "https://meancourseboard.herokuapp.com/api/me"
        
        // Set up headers
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        // Request the data from the api
        Alamofire.request(.GET, apiToContact, headers: headers).validate().responseJSON() { response in
            
            // Add the json info to user
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    print(json)
                    
                    let user = User()
                    
                    user.id = json["_id"].stringValue
                    
                    user.createdAt = json["createdAt"].stringValue
                    user.updatedAt = json["updatedAt"].stringValue
                    
                    user.email = json["email"].stringValue
                    //user.password =
                    
                    user.first = json["first"].stringValue
                    user.last = json["last"].stringValue
                    user.fullname = json["fullname"].stringValue
                    user.username = json["username"].stringValue
                    
                    user.role = json["role"].stringValue
                    
                    user.courses = json["courses"].arrayValue.map{$0["_id"].stringValue}
                    user.products = json["products"].arrayValue.map{$0["_id"].stringValue}
                    
                    user.admin = Bool(json["admin"])
                    
                    complete(user: user, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(user: nil, error: error)
            }
        }
    }
    
}
