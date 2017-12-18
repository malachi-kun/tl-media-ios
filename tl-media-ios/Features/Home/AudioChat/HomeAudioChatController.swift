//
//  HomeAudioChatController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/18.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//
import UIKit
import JSQMessagesViewController
import MobileCoreServices
import AVKit

class HomeAudioChatController:JSQMessagesViewController {
    
    private var messages = [JSQMessage]()
    
    // MARK: PROPERTIES
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()
    
    var icon = #imageLiteral(resourceName: "brain")
    var iconList = [UIImage]()
    
    var conversation:[String] = ["Hello","Hi", "日本語はわかりますか","日本語ちょっとうわかります","絵ですね","ありがとございます"]
    var conversationIndex = 0
    
    // MARK: LIFECYLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // set collectionView background
        let backGroundImageView = UIImageView()
        backGroundImageView.image = #imageLiteral(resourceName: "SanFranciscoCityScape")
        collectionView.backgroundView = backGroundImageView
        
        // Do any additional setup after loading the view, typically from a nib.
        self.senderId = "1"
        self.senderDisplayName = ""
        
        //**generate auto mesage
        for i in 0..<5 {
            createMessage()
        }

        //**generate auto mesage

        inputToolbar.contentView.leftBarButtonItem = nil
        //collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero //hides avatar
        //collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero //hides avatar
        //button.sendActions(for: .touchUpInside)
        
    }
    
    // MARK: COLLECTIONVIEW
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory.avatarImage(with: icon, diameter: 30)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    func createMessage(){
        if senderId == "1" {
            messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: conversation[conversationIndex]))
            self.senderId = "2"
            conversationIndex += 1
        } else {
            messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: conversation[conversationIndex]))
            self.senderId = "1"
            conversationIndex += 1
        }
        
        collectionView.reloadData()
        finishSendingMessage()  //remove from text field.
    }
    
    // MARK: JSQM BUTTON CODE
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
    
        if senderId == "1" {
            messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text))
            iconList.append(#imageLiteral(resourceName: "brain"))
            self.senderId = "2"
        } else {
            messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text))
            self.senderId = "1"
            iconList.append(#imageLiteral(resourceName: "pinky"))
        }
        
        collectionView.reloadData()
        finishSendingMessage()  //remove from text field.
    }
}


