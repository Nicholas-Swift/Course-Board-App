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
    
    // MARK: Messages
    
    static func sendMessage(message: String, id: String) {
        let messageRef = ref.child("messages")
        
        let itemRef = messageRef.childByAutoId()
        let messageItem = [
            "text": message,
            "senderId":id
        ]
        itemRef.setValue(messageItem)
    }
    
    static func getMessage() {
        let messageRef = ref.child("messages")
        
        messageRef.observeEventType(.Value, withBlock: { (snapshot) in
            //print(snapshot)
            
            var messageArray: [(String, String)] = []
            for snap in snapshot.children {
                let senderId = snap.value["senderId"]
                let text = snap.value["text"]
                messageArray.append((String(senderId), String(text)))
            }
            print(messageArray)
            
        })
    }
    
}