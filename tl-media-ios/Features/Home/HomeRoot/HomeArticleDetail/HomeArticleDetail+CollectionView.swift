//
//  HomeArticleDetail+CollectionView.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/10.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

extension HomeArticleDetailController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: COLLECTIONVIEW DATA SOURCE
    // COLLECTION VIEW CODE
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //CELL CODE
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID.HomeArticleDetailCell.rawValue, for: indexPath) as! HomeArticleDetailCell
        cell.frame.size.width = collectionView.frame.size.width
        
        guard let image = articleDetail?.articleImage else { return cell}
        guard let headerTitle = articleDetail?.header else { return cell}
        guard let body = articleDetail?.paragraph else { return cell }
        guard let author = articleDetail?.author else { return cell }
        
        cell.articleHeaderImage.sd_setImage(with: URL(string: image), placeholderImage: #imageLiteral(resourceName: "TL"))
        cell.titleLabel.text = headerTitle
        cell.authorNameLabel.text = author
        cell.bodyLabel.text = body
        cell.playButton.addTarget(self, action: #selector(playAudioPressed), for: .touchUpInside)
        return cell
    }
    

    @objc func playAudioPressed(){
        print("test")
    }
    
    // MARK: COLLECTIONVIEW FLOW LAYOUT
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
