//
//  HomeArticleDetail+CollectionView.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/10.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

extension HomeArticleDetailController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ImageResizeDelegate {

    
    
    // MARK: COLLECTIONVIEW DATA SOURCE
    // COLLECTION VIEW CODE
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //CELL CODE
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("The count is: \(articleElements?.count)")
        return articleElements?.count ?? 1
    }
    
    
    enum cellType:String {
        case image
        case sentence
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //COLLECTIONVIEW AT INDEX 0

        if indexPath.row == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID.HomeArticleDetailCell.rawValue, for: indexPath) as! HomeArticleDetailCell
            cell.frame.size.width = collectionView.frame.size.width
            
            guard let image = articleDetail?.images![0] else { return cell}
            guard let headerTitle = articleDetail?.title[0] else { return cell}
            guard let body = articleDetail?.body else { return cell }
            guard let author = articleDetail?.author else { return cell }
            guard let issueDate = articleDetail?.postDate else { return cell }

            
            cell.articleHeaderImage.sd_setImage(with: URL(string: image), placeholderImage: #imageLiteral(resourceName: "whiteBackGround"))
            cell.titleLabel.text = headerTitle
            cell.authorNameLabel.text = author
            cell.bodyLabel.text = body
            cell.dateLabel.text = issueDate
            cell.playButton.addTarget(self, action: #selector(playAudioPressed), for: .touchUpInside)
            cell.exitButton.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
            return cell
            
        } else {
            if articleElements?[indexPath.row].inputType == cellType.image.rawValue {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID.ImageContent.rawValue, for: indexPath) as! ImageElementCell
            
                guard let imageURL = articleElements?[indexPath.row].content else {return cell}
        
                if let downloadedimage = imageDict[imageURL] {
                    let conversion = (UIScreen.main.bounds.size.height * downloadedimage.ratio)
                    cell.setHeightConversion(height: conversion)
                    cell.imageContent.sd_setImage(with: URL(string: imageURL), placeholderImage: #imageLiteral(resourceName: "whiteBackGround"))
                } else {
                    guard let uncachedImage = cell.imageContent.image else { return cell}
                    downloadImage(urlString:imageURL)
                    cell.imageContent.image = #imageLiteral(resourceName: "whiteBackGround") //placeholder
                }
 
                //cell.imageContent.sd_setImage(with: URL(string: imageURL), placeholderImage: #imageLiteral(resourceName: "whiteBackGround"))
                //print(cell.imageContent.image?.size.height)
                return cell
                
            }else if articleElements?[indexPath.row].inputType == cellType.sentence.rawValue{
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID.ArticleSentenceElement.rawValue, for: indexPath) as! HomeArticleSentenceCell
                
                guard let content = articleElements?[indexPath.row].content else {return cell}
                cell.inputTypeLabel.text = removeHTMLTags(stringToConvert: content)
                return cell
            }
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID.ArticleSentenceElement.rawValue, for: indexPath) as! HomeArticleSentenceCell
        return cell
    }
    
    // MARK: IMAGE DOWNLOADER HELP
    func downloadImage(urlString: String) {
        print("Download Started")
        guard let url = URL(string: urlString) else {return}
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            //print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                let image = UIImage(data: data)
                //save ratio
                let ratio:CGFloat = ((image?.size.height)! / (image?.size.width)!)  // Height over Width
                print(ratio)
                //delegate image cache
                guard let downloadImage = image else {return}
                self.imageDelegate?.imageResizer(url: urlString, image: downloadImage, ratio: ratio)
            }
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    // MARK: DELEGATE METHOD
    func imageResizer(url:String, image: UIImage, ratio: CGFloat) {
        print("urlString:\(url) ratio:\(ratio)")
        imageDict[url] = (image, ratio)
        collectionView.reloadData()
    }
    
    @objc func playAudioPressed(){
        print("play pressed")
    }
    
    @objc func exitButtonPressed(){
        print("exit pressed")
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: COLLECTIONVIEW FLOW LAYOUT
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
}
