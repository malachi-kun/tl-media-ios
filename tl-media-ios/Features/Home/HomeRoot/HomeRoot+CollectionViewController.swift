//
//  HomeRoot+CollectionViewController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/02/16.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

extension HomeRootViewController {
    
    // MARK: COLLECTIONVIEW DELEGATES
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleDetails.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < numOfArticles {
            
            //ARTICLE CELL
            //**HEADLINE ARTICLE CELL
            print("total:\(articleDetails.count)  index:\(indexPath.row)")
            if indexPath.row == 0 {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.headlineArticleCell.rawValue, for: indexPath) as! HomeRootHeadlineArticleCell
                
                cell.headlineArticle.articleImage.sd_setImage(with: URL(string: articleDetails[indexPath.row].images![0]), placeholderImage: #imageLiteral(resourceName: "blackBackGround"))
                cell.headlineArticle.titleLabel.text = articleDetails[indexPath.row].title[0]
                cell.headlineArticle.articleImage.tag = indexPath.row
                cell.headlineArticle.articleImage.isUserInteractionEnabled = true
                //tapGesture for cell
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(articleImageTapped(tapGestureRecognizer:)))
                cell.headlineArticle.articleImage.addGestureRecognizer(tapGestureRecognizer)
                return cell
                
            } else {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.voiceArticle.rawValue, for: indexPath) as! HomeRootViewArticleCell
                
                if indexPath.row+1 < articleDetails.count {
                    cell.voiceArticle.articleImageFirst.sd_setImage(with: URL(string: articleDetails[indexPath.row].images![0]), placeholderImage: #imageLiteral(resourceName: "blackBackGround"))
                    
                    //image interaction
                    let firsttapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(firstArticleImageTapped(tapGestureRecognizer:)))
                    //tap gesture
                    cell.voiceArticle.articleImageFirst.tag = indexPath.row
                    cell.voiceArticle.articleImageFirst.addGestureRecognizer(firsttapGestureRecognizer)
            
                    //article label
                    cell.voiceArticle.titleLabelFirst.text = articleDetails[indexPath.row].title[0]
                    
                } else if indexPath.row+1 == articleDetails.count {
                    
                    cell.voiceArticle.articleImageFirst.sd_setImage(with: URL(string: articleDetails[indexPath.row].images![0]), placeholderImage: #imageLiteral(resourceName: "blackBackGround"))
                    cell.voiceArticle.titleLabelFirst.text = articleDetails[indexPath.row].title[0]
                }
                return cell
            }
            //Tabi Labo Family
        } else if indexPath.item == numOfArticles {
            //category
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.tlFamily.rawValue, for: indexPath) as! HomeRootTabiLaboFamilyCell
            return cell
            
            //Category
        } else if indexPath.item == numOfArticles + 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.category.rawValue, for: indexPath) as! HomeRootCategoryCell
            return cell
        }
        
        //default
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.voiceArticle.rawValue, for: indexPath) as! HomeRootViewArticleCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
