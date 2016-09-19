//
//  ImageHelper.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 9/18/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import UIKit

//class ImageHelper {
//    
//    let imageCache = NSCache()
//    
//}

let imageCache = NSCache()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.objectForKey(urlString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        let url = NSURL(string: urlString)
        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
            
            //download hit an error so lets return out
            if error != nil {
                print(error)
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString)
                    
                    self.image = downloadedImage
                }
            })
            
        }).resume()
    }
    
}