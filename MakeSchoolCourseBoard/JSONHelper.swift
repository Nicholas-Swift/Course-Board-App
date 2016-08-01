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
    
    // Variables
    
    static var baseApi = "https://meancourseboard.herokuapp.com/api/"
    
    // MARK: Courses
    
    // Get all courses, through mini courses to save memory
    static func getAllCourses(complete: ( courses: [MiniCourse]?, error: NSError?) -> Void)
    {
        
        // Url of the api
        let apiToContact = JSONHelper.baseApi + "courses"
        
        // Set up headers
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        // Request the data from api
        Alamofire.request(.GET, apiToContact, headers: headers).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    // Set up courses array and loop through, adding to it
                    var courses = [MiniCourse]()
                    for i in 0...(json.count-1) {
                        //print(json)
                        
                        let miniCourse = MiniCourse()
                        
                        miniCourse.id = json[i]["_id"].stringValue
                        miniCourse.title = json[i]["title"].stringValue
                        miniCourse.instructorName = json[i]["instructor"]["fullname"].stringValue
                        let startDate = DateHelper.toShortDate(json[i]["startsOn"].stringValue)
                        let endDate = DateHelper.toShortDate(json[i]["endsOn"].stringValue)
                        miniCourse.dates = startDate + " - " + endDate
                        
                        courses.append(miniCourse)
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
        let apiToContact = JSONHelper.baseApi + "courses/" + id
        
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
                    course.instructorName = json["instructor"]["fullname"].stringValue
                    course.title = json["title"].stringValue
                    course.description = json["description"].stringValue
                    
                    course.startsOn = json["startsOn"].stringValue
                    course.endsOn = json["endsOn"].stringValue
                    course.hours = json["hours"].stringValue
                    
                    course.location = json["location"].stringValue
                    
                    course.objectives = json["objectives"].arrayValue.map{$0.string!}
                    course.students = json["students"].arrayValue.map{$0["_id"].stringValue}
                    course.studentNames = json["students"].arrayValue.map{$0["fullname"].stringValue}
                    
                    course.posts = json["posts"].arrayValue.map{$0["_id"].stringValue}
                    course.postBodies = json["posts"].arrayValue.map{$0["body"].stringValue}
                    course.postUser = json["posts"].arrayValue.map{$0["user"].stringValue}
                    course.postCreated = json["posts"].arrayValue.map{$0["createdAt"].stringValue}
                    
                    course.products = json["products"].arrayValue.map{$0["_id"].stringValue}
                    course.productNames = json["products"].arrayValue.map{$0["name"].stringValue}
                    
                    complete(course: course, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(course: nil, error: error)
            }
        }
    }
    
    // enroll in specific course
    static func enrollCourse(id: String, complete: ( bool: Bool?, error: NSError?) -> Void)
    {
        
        // Call the api
        let apiToContact = JSONHelper.baseApi + "courses/" + id + "/enroll"
        
        // Set up headers
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        // Request the data from api
        Alamofire.request(.PUT, apiToContact, headers: headers).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    //let json = JSON(value)
                    //print(json)
                    
                    complete(bool: true, error: nil)
                }
            case .Failure(let error):
                print(error)
                complete(bool: nil, error: error)
            }
        }
    }
    
    // Add a course
    static func addCourse(tuple: (instructor: String, title: String, description: String, startsOn: String, endsOn: String, location: String, hours: String, objectives: [String]), complete: ( bool: Bool?, error: NSError?) -> Void)
    {
        
        // Call the api
        let apiToContact = JSONHelper.baseApi + "courses"
        
        // Set up headers
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        // Set up info
        var tempDict: [String: AnyObject] = [:]
        
        tempDict["instructor"] = "572a21580608f80300f95714" //tuple.instructor
        tempDict["title"] = tuple.title
        tempDict["description"] = tuple.description
        tempDict["startsOn"] = "2017-01-16T08:00:00.000Z" //tuple.startsOn
        tempDict["endsOn"] = "2017-03-24T07:00:00.000Z" //tuple.endsOn
        tempDict["location"] = tuple.location
        tempDict["hours"] = tuple.hours
        tempDict["objectives"] = tuple.objectives
        
        print(tempDict)
        
        // Must include course or the server crashes
        Alamofire.request(.POST, apiToContact, headers: headers, parameters: tempDict, encoding: .JSON).validate().responseJSON() { response in
            print(response)
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                    print("complete")
                    
                    complete(bool: true, error: nil)
                }
            case .Failure(let error):
                print(error)
                complete(bool: nil, error: error)
            }
        }
    }
    
    // MARK: Products
    
    // Get all products, in miniProducts to save memory
    static func getAllProducts(complete: ( products: [MiniProduct]?, error: NSError?) -> Void)
    {
        
        // Call the api
        let apiToContact = JSONHelper.baseApi + "products"
        
        // Set up headers
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        // Request the data from api
        Alamofire.request(.GET, apiToContact, headers: headers).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    var products = [MiniProduct]()
                    
                    for i in 0...(json.count-1) {
                        //print(json[i])
                        
                        let miniProduct = MiniProduct()
                        
                        miniProduct.id = json[i]["_id"].stringValue
                        miniProduct.title = json[i]["name"].stringValue
                        miniProduct.instructorName = json[i]["instructor"]["fullname"].stringValue
                        miniProduct.info = json[i]["problem"].stringValue
                        
                        products.append(miniProduct)
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
        let apiToContact = JSONHelper.baseApi + "products/" + id
        
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
                    product.instructorName = json["instructor"]["fullname"].stringValue // for instructor
                    product.course = json["course"].stringValue
                    product.problem = json["problem"].stringValue
                        
                    product.valueProp = json["valueProp"].stringValue
                    product.githubUrl = json["githubUrl"].stringValue
                    product.agileUrl = json["agileUrl"].stringValue
                    product.liveurl = json["liveUrl"].stringValue
                        
                    product.objectives = json["objectives"].arrayValue.map{$0.string!}
                    product.posts = json["posts"].arrayValue.map{$0["_id"].stringValue}
                        
                    product.customer = json["customer"].stringValue //???
                    product.assumptions = json["assumptions"].stringValue //???
                    product.finishedProduct = json["finishedProduct"].stringValue //???
                    product.mvp = json["mvp"].stringValue //???
                        
                    product.contributors = json["contributors"].arrayValue.map{$0["_id"].stringValue}
                    product.contributorNames = json["contributors"].arrayValue.map{$0["fullname"].stringValue}
                    
                    // complete and return product
                    complete(product: product, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(product: nil, error: error)
            }
        }
    }
    
    // Join in specific product
    static func joinProduct(id: String, complete: ( bool: Bool?, error: NSError?) -> Void)
    {
        
        // Call the api
        let apiToContact = JSONHelper.baseApi + "products/" + id + "/join"
        
        // Set up headers
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        // Request the data from api
        Alamofire.request(.PUT, apiToContact, headers: headers).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    //let json = JSON(value)
                    //print(json)
                    
                    complete(bool: true, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(bool: nil, error: error)
            }
        }
    }
    
    // Add a product
    static func addProduct(tuple: (name: String, instructor: String, course: String, problem: String), complete: ( bool: Bool?, error: NSError?) -> Void)
    {
        
        // Call the api
        let apiToContact = JSONHelper.baseApi + "products"
        
        // Set up headers
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        // Set up info
        var tempDict: [String: AnyObject] = [:]
        
        tempDict["name"] = tuple.name
        tempDict["instructor"] = "571fe124831e22030010b9bd"
        tempDict["course"] = "5730fd6b769290030048aafa" // NEED TO HAVE COURSE IN PRODUCT RIGHT NOW!!!
        tempDict["problem"] = tuple.problem
        
        // Must include course or the server crashes
        Alamofire.request(.POST, apiToContact, headers: headers, parameters: tempDict, encoding: .JSON).validate().responseJSON() { response in
            print(response)
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                    print("complete")
                    
                    complete(bool: true, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(bool: nil, error: error)
            }
        }
    }
    
    // Edit a product
    static func editProduct(tuple: (name: String, advisor: String, course: String, problem: String, github: String, agile: String, live: String, valueProp: String, customer: String, assumption: String, finishedProduct: String, mvp: String), complete: ( bool: Bool?, error: NSError?) -> Void)
    {
        
        // Call the api
        let apiToContact = JSONHelper.baseApi + "products/579ea5c57fc82e0300f611c7"
        
        // Set up headers
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        print(tuple);
        
        // Set up info
        //var tempDict: [String: AnyObject] = [:]
        
//        // Must include course or the server crashes
//        Alamofire.request(.POST, apiToContact, headers: headers, parameters: tempDict, encoding: .JSON).validate().responseJSON() { response in
//            print(response)
//            switch response.result {
//            case .Success:
//                if let value = response.result.value {
//                    let json = JSON(value)
//                    print(json)
//                    print("complete")
//                    
//                    complete(bool: true, error: nil)
//                    
//                }
//            case .Failure(let error):
//                print(error)
//                complete(bool: nil, error: error)
//            }
//        }
    }
    
    // MARK: Users
    
    // Get me
    static func getMe(complete: (user: User!, error: NSError?) -> Void) {
        
        // Call the api
        let apiToContact = JSONHelper.baseApi + "me"
        
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
                    
                    user.first = json["first"].stringValue
                    user.last = json["last"].stringValue
                    user.fullname = json["fullname"].stringValue
                    user.username = json["username"].stringValue
                    
                    user.role = json["role"].stringValue
                    
                    user.courses = json["courses"].arrayValue.map{$0["_id"].stringValue}
                    user.courseNames = json["courses"].arrayValue.map{$0["title"].stringValue}
                    user.products = json["products"].arrayValue.map{$0["_id"].stringValue}
                    user.productNames = json["products"].arrayValue.map{$0["name"].stringValue}
                    user.posts = json["posts"].arrayValue.map{$0["_id"].stringValue}
                    
                    user.admin = Bool(json["admin"])
                    
                    complete(user: user, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(user: nil, error: error)
            }
        }
    }
    
    // Get specific user
    static func getUser(id: String!, complete: (user: User!, error: NSError?) -> Void) {
        
        // Call the api
        let apiToContact = JSONHelper.baseApi + "users/" + id
        
        // Set up headers
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        // Request the data from the api
        Alamofire.request(.GET, apiToContact, headers: headers).validate().responseJSON() { response in
            
            // Add the json info to user
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    //print(json)
                    
                    let user = User()
                    
                    user.id = json["_id"].stringValue
                    
                    user.createdAt = json["createdAt"].stringValue
                    user.updatedAt = json["updatedAt"].stringValue
                    
                    user.email = json["email"].stringValue
                    
                    user.first = json["first"].stringValue
                    user.last = json["last"].stringValue
                    user.fullname = json["fullname"].stringValue
                    user.username = json["username"].stringValue
                    
                    user.role = json["role"].stringValue
                    
                    user.courses = json["courses"].arrayValue.map{$0["_id"].stringValue}
                    user.courseNames = json["courses"].arrayValue.map{$0["title"].stringValue}
                    user.products = json["products"].arrayValue.map{$0["_id"].stringValue}
                    user.productNames = json["products"].arrayValue.map{$0["name"].stringValue}
                    user.posts = json["posts"].arrayValue.map{$0.stringValue}
                    
                    user.admin = Bool(json["admin"])
                    
                    complete(user: user, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(user: nil, error: error)
            }
        }
    }
    
    // update a user
    static func updateUser(info: (first: String, last: String, username: String, email: String, role: String), complete: ( bool: Bool?, error: NSError?) -> Void)
    {
        
        // Call the api
        let apiToContact = JSONHelper.baseApi + "me"
        
        // Set up headers
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        // Request the data from the api
        Alamofire.request(.GET, apiToContact, headers: headers).validate().responseJSON() { response in
            
            // Add the json info to user
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    var json = JSON(value)
                    
                    //print(json)
                    
                    // Edit json with the updated info
                    json["first"] = JSON(stringLiteral: info.first)
                    
                    Alamofire.request(.PUT, apiToContact, headers: headers, parameters: json.dictionaryObject, encoding: .JSON).validate().responseJSON() { response in
                        switch response.result {
                        case .Success:
                            if let value = response.result.value {
                                //let json = JSON(value)
                                //print(json)
                                
                                complete(bool: true, error: nil)
                                
                            }
                        case .Failure(let error):
                            print(error)
                            complete(bool: nil, error: error)
                        }
                    }
                    
                    //complete(bool: true, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(bool: false, error: error)
            }
        }
    }
    
    // MARK: Posts
    
    // Get all the posts from a single course
    static func getCoursePosts(id: String!, complete: (posts: [Post]!, error: NSError?) -> Void) {
        
        // Call the api
        let apiToContact = JSONHelper.baseApi + "courses/" + id + "/posts"
        
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
                    
                    var posts: [Post] = []
                    for i in 0...json.count-1 {
                        let post = Post()
                        
                        post.course = json[i]["course"].stringValue
                        post.body = json[i]["body"].stringValue
                        post.user = json[i]["user"]["username"].stringValue
                        post.createdAt = json[i]["createdAt"].stringValue
                        
                        posts.append(post)
                    }
                    
                    complete(posts: posts, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(posts: nil, error: error)
            }
        }
    }
    
    // Get all the posts from a specific user
    static func getUserPosts(id: String!, complete: (posts: [Post]!, error: NSError?) -> Void) {
        
        // Call the api
        let apiToContact = JSONHelper.baseApi + "users/" + id + "/posts"
        
        // Set up headers
        let headers = ["Authorization": "Basic " + LoginHelper.token]
        
        // Request the data from the api
        Alamofire.request(.GET, apiToContact, headers: headers).validate().responseJSON() { response in
            
            // Add the json info to user
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    //print(json)
                    
                    complete(posts: nil, error: nil)
                    
                }
            case .Failure(let error):
                print(error)
                complete(posts: nil, error: error)
            }
        }
    }
    
}
