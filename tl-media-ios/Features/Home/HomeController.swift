//
//  HomeController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/20.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//
import UIKit
import SDWebImage


class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let testImageURL = "https://d2ygv0wrq5q6bx.cloudfront.net/uploads/image/files/129660/3d32f3a212ca7f5923a5720094d48416b7955d40.png"
    
    // MARK: PROPERTIES
    //Get data from server
    let networkManager = NetworkManager()
    
    enum catList:String {
        case topic
        case tlFamily
        case category
    }
    
    //image list
    var imageList = [Int:String]()
    var headerImage = UIImage()
    
    //items to put into collectionView cells
    var sectionItems:[String] = [catList.topic.rawValue, catList.tlFamily.rawValue, catList.category.rawValue]
    
    //MARK COLLECTION VIEW HEADER HEIGHT
    let headerHeight:CGFloat = 350
    
    //MAKE CELL HEADER NAMES TO BE REGISTERED
    enum headerCellType:String {
        case headerID
        case topic
        case tlFamily
        case category
    }
    
    //MAKE COLLECTION VIEW CELL HEIGHT SIZES
    enum sectionCellSizes:CGFloat {
        case topicHeight = 160
        case tabiLabiFamilyHeight = 370
        case categoryHeight = 425
        case defaultValue = 260
    }
    
    //SECTION TITLE HEADERS
    enum sectionTitle:String {
        case tabiLaboFamily = "TABI LABO FAMILY"
        case category = "CATEGORY"
    }
    
    var headerTitle:[String]?
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        
        collectionView?.backgroundColor = .black
        navigationItem.title = "Tabi Labo"
        headerTitle = ["", sectionTitle.tabiLaboFamily.rawValue, sectionTitle.category.rawValue]
        
        //CELL REGISTRATION
        //header
        collectionView?.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellType.headerID.rawValue)
        
        //cell registration
        collectionView?.register(TopicSection.self, forCellWithReuseIdentifier: cellType.topic.rawValue)
        collectionView?.register(CategorySection.self, forCellWithReuseIdentifier: cellType.category.rawValue)
        collectionView?.register(TabiLaboFamilySection.self, forCellWithReuseIdentifier: cellType.tlFamily.rawValue)
    }

    // MARK: COLLECTIONVIEW CODE
    // COLLECTION VIEW CODE
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //HEADER CODE
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellType.headerID.rawValue, for: indexPath) as! HomeHeader
        
        if imageList.count > 0 {
            print(imageList[0])
            guard let imageURLString = imageList[0] else {return header}
            header.headerImage.sd_setImage(with: URL(string: imageURLString), placeholderImage: #imageLiteral(resourceName: "TL"))
            return header
        }
        
         header.headerImage.image = #imageLiteral(resourceName: "TL")
        return header
    }
    

    
    //CELL CODE
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.topic.rawValue, for: indexPath) as! TopicSection
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.tlFamily.rawValue, for: indexPath) as! TabiLaboFamilySection
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.category.rawValue, for: indexPath) as! CategorySection
            return cell
        }
    }
    
    //FLOW LAYOUT : header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: headerHeight)
    }
    
    //FLOW LAYOUT : cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = view.frame.width
        switch indexPath.item {
        case 0:
            return CGSize(width: width, height: sectionCellSizes.topicHeight.rawValue)
        case 1:
            return CGSize(width: width, height: sectionCellSizes.tabiLabiFamilyHeight.rawValue)
        case 2:
            return CGSize(width: width, height: sectionCellSizes.categoryHeight.rawValue)
        default:
            return CGSize(width: width, height: sectionCellSizes.defaultValue.rawValue)
        }
    }
}

extension HomeController: ArticleContentDelegate {
    func articleContentList(articleModelList: [ArticleContentModel], articleContentModelList: [Int : [ArticleContentModel]]) {
        
        var i = 0
        for inputType in articleModelList {
            if inputType.input == "image"{
                self.imageList[i] = inputType.content
                print("raw: \(inputType.content) \n iL:\(imageList[i])")
                i += 1
            }
        }
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}


