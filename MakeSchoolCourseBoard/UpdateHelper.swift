//
//  UpdateHelper.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/26/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import UIKit

class UpdateHelper {
    
    static var boardUpdated = false
    static var coursesUpdated = false
    static var accountUpdated = false
    static var productsUpdated = false
    
    static func updateAll() {
        boardUpdated = false
        coursesUpdated = false
        accountUpdated = false
        productsUpdated = false
    }
    
}