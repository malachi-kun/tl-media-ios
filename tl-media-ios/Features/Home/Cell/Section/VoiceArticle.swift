//
//  TopicSection.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/27.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit


class VoiceArticle:UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ArticleDelegate {
    
    // MARK: UI ELEMENTS
    let rowsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    // MARK: PROPERTIES
    let networkManager = HomeNetworking()
    var articleDetails = [ArticleModel]()
    var indexPressed:Int?
   
    // MARK: LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)

        networkManager.delegateProd = self
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ASSIST METHODS
    func setupView(){
        
        //register cell
        rowsCollectionView.register(VoiceArticleCell.self, forCellWithReuseIdentifier:cellType.voiceArticle.rawValue)
        
        //add to UI
        addSubview(rowsCollectionView)
  
        //delegate assign
        rowsCollectionView.delegate = self
        rowsCollectionView.dataSource = self
        
        //auto layout
        rowsCollectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    // MARK: COLLECTIONVIEW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return articleDetails.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.voiceArticle.rawValue, for: indexPath) as! VoiceArticleCell
        
        if articleDetails.count > 0{
            cell.imageView.sd_setImage(with: URL(string: articleDetails[indexPath.row].images![0]), placeholderImage: #imageLiteral(resourceName: "TL"))
            cell.titleLabel.text = articleDetails[indexPath.row].title[0]
            cell.playButton.tag = indexPath.item
            cell.playButton.addTarget(self, action: #selector(playPressed(withSender:)), for: .touchUpInside)
            

            cell.layer.shouldRasterize = true
            cell.layer.rasterizationScale = UIScreen.main.scale
            return cell
        } else {
            return cell
        }
    }
    
    @objc func playPressed(withSender:AnyObject){
        guard (withSender.tag) != nil else { return }
        print("cell play button pressed.")
        
        // MARK: NotificationCenter
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationCalls.playAudioArticlePressed.rawValue), object: self, userInfo: [notificationCalls.articleDetails.rawValue:articleDetails[withSender.tag]])
    }
    
    //FLOW LAYOUT : cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 200)
    }
    
    // MARK: DELEGATE METHODS
    func articleContentList(articleContent: [ArticleModel]) {
        articleDetails = articleContent
        rowsCollectionView.reloadData()
    }
}
