//
//  ChannelViewController.swift
//  MakeSchoolCourseBoard
//
//  Created by Nicholas Swift on 7/26/16.
//  Copyright © 2016 Nicholas Swift. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChannelViewController: JSQMessagesViewController {
    
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(ColorHelper.blueColor)
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.lightGrayColor())
    var messages = [JSQMessage]()
    
    // View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.loadMessages()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadMessagesView() {
        self.collectionView.reloadData()
    }
    
}

extension ChannelViewController {
    
    func loadMessages() {
        
        // Get messages from firebase
        let messageRef = FirebaseHelper.ref.child("messages")
        
        messageRef.observeEventType(.Value, withBlock: { (snapshot) in
            
            for snap in snapshot.children {
                let senderId = snap.value["senderId"]!
                let text = snap.value["text"]!
                
                let message = JSQMessage(senderId: String(senderId), displayName: "TempName", text: String(text))
                self.messages += [message]
            }
            self.reloadMessagesView()
            
        })
    }
    
    func setup() {
        self.senderId = LoginHelper.id
        self.senderDisplayName = "TempName"
    }
    
}

extension ChannelViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        let data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
        self.messages.removeAtIndex(indexPath.row)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let data = messages[indexPath.row]
        switch(data.senderId) {
        case self.senderId:
            return self.outgoingBubble
        default:
            return self.incomingBubble
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
}

//MARK - Toolbar
extension ChannelViewController {
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        //let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        //self.messages += [message]
        
        FirebaseHelper.sendMessage(text, id: senderId)
        
        self.finishSendingMessage()
        reloadMessagesView()
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        print("Accessory button was pressed")
    }
}