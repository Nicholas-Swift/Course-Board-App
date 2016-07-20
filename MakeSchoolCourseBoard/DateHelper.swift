//
//  DateHelper.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/14/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation

class DateHelper {
    
    // Set up months
    static let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    // Turn time into a full date (January 23, 2016).
    static func toFullDate(str: String) -> String {
        
        let ymd = str[0...9] // 2016-05-25
        let ymdArray = ymd.componentsSeparatedByString("-")
        let returnStr = (months[Int(ymdArray[1])!] + " " + ymdArray[2] + ", " + ymdArray[0])
        
        return(returnStr)
    }
    
    // Turn time into a short date (Jan 27)
    static func toShortDate(str: String) -> String {
        
        let ymd = str[0...9] //2016-05-25
        let ymdArray = ymd.componentsSeparatedByString("-")
        let returnStr = (months[Int(ymdArray[1])!].trunc(3, trailing: "") + " " + ymdArray[2])
        
        return(returnStr)
    }
}

extension String {
    
    // Return a range in the string
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = startIndex.advancedBy(r.endIndex - r.startIndex)
            
            return self[Range(startIndex ..< endIndex)]
        }
    }
    
    // Truncate string length
    func trunc(length: Int, trailing: String? = "...") -> String {
        if self.characters.count > length {
            return self.substringToIndex(self.startIndex.advancedBy(length)) + (trailing ?? "")
        } else {
            return self
        }
    }
}