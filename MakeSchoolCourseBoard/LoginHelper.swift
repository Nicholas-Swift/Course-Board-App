//
//  LoginHelper.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/19/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginHelper {
    
    // Token for authentication, populated by login()
    static var token: String!
    
    static var id: String!
    static var role: String!
    
    // Log in to account
    static func login(email: String, password: String, complete: (success: Bool, error: NSError?) -> Void) {
        
        // Pass in email/username and password
        let params = ["email": email,
                      "password": password]
        
        // Contact correct auth/login api
        let apiToContact = "https://meancourseboard.herokuapp.com/auth/login"
        
        // Send in alamofire post request, passing in email and pass parameters.
        Alamofire.request(.POST, apiToContact, parameters: params).validate().responseJSON() { response in
            
            switch response.result {
                
            // successful request
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    // Set the token
                    token = json["token"].stringValue
                    
                    JSONHelper.getMe({ (user, error) in
                        self.id = user.id
                        self.role = user.role
                        complete(success: true, error: nil)
                    })
                }
                else {
                    complete(success: false, error: nil)
                }
                
            // failed request
            case .Failure(let error):
                print(error)
                complete(success: false, error: error)
            }
        }
    }
    
    static func logout() {
        token = nil
        id = nil
        role = nil
        
        UpdateHelper.updateAll()
    }
    
}