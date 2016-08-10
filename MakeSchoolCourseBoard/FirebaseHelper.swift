
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
    
    static var datRef = FIRDatabase.database().reference()
    static var storRef = FIRStorage.storage().reference()
    
    static func FirebaseLogin() {
        
    }
    
    // Uploading Pictures
    
    static func uploadPic(image: UIImage) {
        
        // Create a reference to the path where you want to upload the file
        let storageRef: FIRStorageReference = storRef.child("ProfileImages/\(LoginHelper.id).jpg")
        let profileImageData = UIImageJPEGRepresentation(image, 0.25)
        
        // Upload the file to the path defined above
        storageRef.putData(profileImageData!, metadata: nil) { metadata, error in
            if (error != nil)
            {
                print("Image not stored: ", error?.localizedDescription)
            }
            else
            {
                //Stores the profile image URL and sends it to the next function
                let downloadURL = metadata!.downloadURL()
                self.uploadPicUrl(downloadURL!)
            }
        }
        
    }
    
    static func uploadPicUrl(url: NSURL) {
        let picsRef = datRef.child("profilePictures")
        
        let itemRef = picsRef.child(LoginHelper.id)
        itemRef.setValue(url.URLString)
    }
    
    static func getPicUrl(id: String, complete: (url: String?, error: NSError?) -> Void) {
        
        let picsRef = datRef.child("profilePictures/\(id)")
        
        picsRef.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            let urlString = snapshot.value as? String
            
            if urlString == "" || urlString == nil {
                complete(url: nil, error: NSError(domain: "Error", code: 404, userInfo: nil))
            }
            else {
                complete(url: urlString, error: nil)
            }
            
        }, withCancelBlock: {
            (error) in
            complete(url: nil, error: error)
        })
        
    }
    
    // MARK: Pictures
    
//    static func uploadProfilePic(image: UIImage) {
//        
//        let picsRef = ref.child("profilePic")
//        
//        // Create a root reference
//        let storageRef = picsRef
//        // Create a reference to "mountains.jpg"
//        let mountainsRef = storageRef.child("mountains.jpg")
//        
//        // Create a reference to 'images/mountains.jpg'
//        let mountainImagesRef = storageRef.child("images/mountains.jpg")
//        
//        // While the file names are the same, the references point to different files
//        mountainsRef.name == mountainImagesRef.name            // true
//        mountainsRef.fullPath == mountainImagesRef.fullPath    // false
//        
//        // Data in memory
//        let data: NSData = ...
//        // Create a reference to the file you want to upload
//        let riversRef = storageRef.child("images/rivers.jpg")
//        
//        // Upload the file to the path "images/rivers.jpg"
//        let uploadTask = riversRef.putData(data, metadata: nil) { metadata, error in
//            if (error != nil) {
//                // Uh-oh, an error occurred!
//            } else {
//                // Metadata contains file metadata such as size, content-type, and download URL.
//                let downloadURL = metadata!.downloadURL
//            }
//        }
//        
//    }
    
//    static func getProfilePic(id: String, complete: (image: UIImage!, error: NSError?) -> Void) {
//        print(id)
//        let picturesRef = ref.child("profilePictures").child("571fe124831e22030010b9bd")
//
//        picturesRef.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
//            
//            //print(snapshot)
//            
//            let base64String = snapshot.value as! String
//            print(base64String)
//            let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0))
//            let image: UIImage = (UIImage(data: decodedData!) ?? nil)!
//            
//            complete(image: image, error: nil)
//            
////            if let image = UIImage(data: decodedData!) {
////                complete(image: image, error: nil)
////            }
////            else {
////                complete(image: nil, error: nil)
////            }
//        }, withCancelBlock: { (snapshot) in
//            complete(image: nil, error: nil)
//        })
//    }
//
//    static func uploadProfilePic(image: UIImage) {
//        
//        let picturesRef = ref.child("profilePictures")
//        
//        let imageData: NSData = UIImagePNGRepresentation(image)!
//        let base64String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
//        
////        let itemRef = picturesRef.child(LoginHelper.id)
////        itemRef.setValue(base64String)
//    }
    
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