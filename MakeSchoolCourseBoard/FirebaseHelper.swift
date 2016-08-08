
//
//  FirebaseHelper.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/26/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import Foundation
import Firebase

class FirebaseHelper {
    
    static var ref = FIRDatabase.database().reference()
    
    static func FirebaseLogin() {
        
        
        
    }
    
    // MARK: Pictures
    
    static func getProfilePic(id: String, complete: (image: UIImage!, error: NSError?) -> Void) {
        print(id)
        let picturesRef = ref.child("profilePictures").child("571fe124831e22030010b9bd")

        picturesRef.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            print(snapshot)
            
            let base64String = snapshot.value as! String
            let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0))
            if let image = UIImage(data: decodedData!) {
                complete(image: image, error: nil)
            }
            else {
                complete(image: nil, error: nil)
            }
        }, withCancelBlock: { (snapshot) in
            complete(image: nil, error: nil)
        })
    }
    
    static func uploadProfilePic(image: UIImage) {
        
        let picturesRef = ref.child("profilePictures")
        
        let imageData: NSData = UIImagePNGRepresentation(image)!
        let base64String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
//        let itemRef = picturesRef.child(LoginHelper.id)
//        itemRef.setValue(base64String)
    }
    
//    // MESSAGES
//    static func sendMessage(message: String, id: String) {
//        let messageRef = ref.child("messages")
//        
//        let itemRef = messageRef.childByAutoId()
//        let messageItem = [
//            "text": message,
//            "senderId":id
//        ]
//        itemRef.setValue(messageItem)
//    }
//    
//    static func getMessage() {
//        let messageRef = ref.child("messages")
//        
//        messageRef.observeEventType(.Value, withBlock: { (snapshot) in
//            //print(snapshot)
//            
//            var messageArray: [(String, String)] = []
//            for snap in snapshot.children {
//                let senderId = snap.value["senderId"]
//                let text = snap.value["text"]
//                messageArray.append((String(senderId), String(text)))
//            }
//            print(messageArray)
//            
//        })
//    }
    
}