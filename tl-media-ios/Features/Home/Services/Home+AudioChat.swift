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
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.red)
    }()
    
    var iconList:[String:UIImage] = [String:UIImage]()
    var iconSize:UInt = 30
    
    var conversationList:[chatPerson] = [chatPerson]()
    var conversation:[String] = ["Hello","Hi", "日本語はわかりますか","日本語ちょっとうわかります","絵ですね","ありがとございます"]
    var conversationIndex = 0
    
    // MARK: LIFECYLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // set collectionView background
        let backGroundImageView = UIImageView()
        backGroundImageView.image = #imageLiteral(resourceName: "SanFranciscoCityScape")
        collectionView.backgroundView = backGroundImageView
        
        // MARK: Blur code
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = (collectionView.backgroundView?.bounds)!
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundView?.addSubview(blurEffectView)
        
        // Do any additional setup after loading the view, typically from a nib.
        requiredClassInit()
        
        //**generate auto mesage
            generateFakeConversation()
        //**generate auto mesage
        
        inputToolbar.contentView.leftBarButtonItem = nil
        let avatarWidth = 50
        let avatarHeight = avatarWidth
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize(width: avatarWidth, height: avatarHeight)
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize(width: avatarWidth, height: avatarHeight)
    }
    
    private func requiredClassInit(){
        self.senderId = "1"             //Deleting this will cause crash
        self.senderDisplayName = ""     //Deleting this will cause crash
    }
    
    private func generateFakeConversation(){
        let personBrain = chatPerson(id: "1", name: "", personIcon: #imageLiteral(resourceName: "brain"))
        let personTL = chatPerson(id: "2", name: "", personIcon: #imageLiteral(resourceName: "TL"))
        
        if let brainID = personBrain.id, let TLid = personTL.id {
            iconList[brainID] = personBrain.personIcon
            iconList[TLid] = personTL.personIcon
            
            //1
            messages.append(JSQMessage(senderId: personBrain.id, displayName: personBrain.name, text: "Hi"))
            //2
            messages.append(JSQMessage(senderId: personTL.id, displayName: personTL.name, text: "Hello!"))
            //3
            messages.append(JSQMessage(senderId: personTL.id, displayName: personTL.name, text: "Welcome to Tabi Labo :)"))
            //4
            messages.append(JSQMessage(senderId: personBrain.id, displayName: personBrain.name, text: "Thank you!"))
            //5
            messages.append(JSQMessage(senderId: personTL.id, displayName: personTL.name, text: "What would you like to know?"))
            //6
            messages.append(JSQMessage(senderId: personBrain.id, displayName: personBrain.name, text: "Everything!!!"))
            
            collectionView.reloadData()
            finishSendingMessage()  //remove from text field.
        }
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
        _ = JSQMessagesBubbleImageFactory()
        
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        //return JSQMessagesAvatarImageFactory.avatarImage(with: conversationList[indexPath.item].personIcon, diameter: iconSize)
        //return JSQMessagesAvatarImageFactory.avatarImage(with: iconList[indexPath.item], diameter: iconSize)
        
        return JSQMessagesAvatarImageFactory.avatarImage(with: iconList[messages[indexPath.item].senderId], diameter: iconSize)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!{
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat{
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    // MARK: JSQM BUTTON CODE
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        //do nothing
    }
}


