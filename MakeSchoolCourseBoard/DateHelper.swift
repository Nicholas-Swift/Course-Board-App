//
//  DateHelper.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/14/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation

class DateHelper {
    
    //2016-05-25T01:10:10.278Z
    
    static let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    static let monthsShort = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    static func stringFromDateFull(str: String) -> String {
        
        let ymd = str[0...9]
        let ymdArray = ymd.componentsSeparatedByString("-")
        let returnStr = (months[Int(ymdArray[1])!] + " " + ymdArray[2] + ", " + ymdArray[0])
        return(returnStr)
    }
    
    static func stringFromDateShort(str: String) -> String {
        let ymd = str[0...9]
        let ymdArray = ymd.componentsSeparatedByString("-")
        let returnStr = (monthsShort[Int(ymdArray[1])!] + " " + ymdArray[2])
        return(returnStr)
    }
    
}

extension String {
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = startIndex.advancedBy(r.endIndex - r.startIndex)
            
            return self[Range(startIndex ..< endIndex)]
        }
    }
}