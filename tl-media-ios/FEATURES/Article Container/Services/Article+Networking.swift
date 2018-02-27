//
//  NetworkManager.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/28.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//
import UIKit
import Foundation

class ArticleNetworkService {

    // MARK: PROPERTIES
    
    // delegate prop.
    var delegateProd:ArticleDelegate?
    var delegateElements:ArticleElementListDelegate?
    
    //prop
    var articleList = [ArticleModel]()
    var articleElementList = [ArticleDetailElementModel]()
    var authorList = [String:String]()
    
    //Server endpoint
    enum authHeader:String{
        case authType = "Authorization"
        case authString = "Bearer 18ea0f254ce9bef70b6d95e10b03c6c36d9e4155c1fcc2322f69ab92c52069d2"
        case devUrl = "https://cms-api-dev.tabi-labo.com/api/v1/article"
        case prodUrl = "https://cms-api.tabi-labo.com/api/v1/article"
        case prodPostedUrl = "https://cms-api.tabi-labo.com/api/v1/article?status=posted"
        case prodAuthor = "https://cms-api.tabi-labo.com/api/v1/author"
    }
    
    enum env:String{
        case dev
        case prod
    }
    
    //SELECTED ENVIRONMENT
    var environment = env.prod.rawValue  // dev or prod
  
    // MARK: LIFECYCLE
    init(id:String?){
        if let id = id {
            self.getFromProdEndpoint(id:id)
        } else {
            self.getFromProdEndpoint(id:nil)
            self.getProdAuthorList()
        }
    }
    
    // MARK: **PROD Article CODEABLE STRUCTURE**
    struct prodArticle:Decodable {
        var hits:hit
    }
    
    struct hit:Decodable{
        var hit:[editorials]
    }
    
    struct editorials:Decodable{
        var id:String
        var fields:field
    }
    
    struct field:Decodable{
        var status:String
        var author_name:String
        var titles:[String]
        var body:String
    }

    // MARK: FETCH FROM NETWORK CODE
    func getFromProdEndpoint(id:String?){

        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [authHeader.authType.rawValue : authHeader.authString.rawValue]
        
        let session = URLSession(configuration: config)
        
        var address:String?
        var initialReq:Bool = true
        
        //if 'id' received, fetch article detail.
        if let id = id {
            address = "\(authHeader.prodUrl.rawValue)/\(id)" //remove two options
            initialReq = false
        } else {
            address = "\(authHeader.prodPostedUrl.rawValue)"
            initialReq = true
        }
    
        guard let retrievedAddress = address else {return}
        guard let url = NSURL(string: retrievedAddress) else { return }
        
        let task = session.dataTask(with: url as URL) {
            (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {return}
            
            let connectionEstablished = self.checkConnectionStatus(httpResponse: httpResponse)
            if connectionEstablished {
                do{
                    //decode and place article IDs in an Array
                    let json = try JSONSerialization.jsonObject(with: data!)
                    //print(json)
                    //getAuthorList()
                    
                    if initialReq {
                        self.parseJsonData(json: json)
                        //put to main thread
                        DispatchQueue.main.async {
                            self.delegateProd?.articleContentList(articleContent: self.articleList)
                        }
                    } else {
                        self.parseJsonForArticleDetails(json:json)
                        //put to main thread
                        DispatchQueue.main.async {
                            self.delegateElements?.getArticleElements(elements: self.articleElementList)
                        }
                    }
                }catch let error {
                    print("error: ", error)
                }
            }
        }
        task.resume()
    }
    
    func getProdAuthorList(){
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [authHeader.authType.rawValue : authHeader.authString.rawValue]
        
        let session = URLSession(configuration: config)
        
        let address = authHeader.prodAuthor.rawValue
        guard let url = NSURL(string: address) else { return }
        
        let task = session.dataTask(with: url as URL) {
            (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {return}
           
            let connectionEstablished = self.checkConnectionStatus(httpResponse: httpResponse)
            if connectionEstablished {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!)
                    self.parseAuthorJsonData(json: json)
                    
                    //put to main thread
                    DispatchQueue.main.async {
                        self.delegateProd?.authorList(authors: self.authorList)
                    }
                }catch let error {
                    print("error: ", error)
                }
            }
        }
        task.resume()
    }
    

    
    //enum for parsing data in method below
    enum articleNodes:String{
        case article_id
        case author_id
        case body
        case create_user_name
        case created_at
        case post_date
        case tags
        case titles
        case eye_catch_urls
        case images
    }
    
    func parseJsonData(json:Any){
        let jsonObject = json as! [String:AnyObject]
        let articleDetails = jsonObject["articles"]
        
        guard let articleDeets = articleDetails else {return}
        let articleArray = articleDeets as! [AnyObject]
        for article in articleArray {
            if article["status"] as! String ==  "posted" {
                print(article)
                let status = "posted"
                if let id = article[articleNodes.article_id.rawValue]
                {
                    guard let id = id else {return}
                    guard let authorId = article[articleNodes.author_id.rawValue] else {return}
                    let author = article[articleNodes.create_user_name.rawValue] as! String
                    let title = article[articleNodes.titles.rawValue] as! [String]
                    let body = article[articleNodes.body.rawValue] as! String
                    let postDate = article[articleNodes.post_date.rawValue] as! String
                    let eyeCatchUrls = article[articleNodes.eye_catch_urls.rawValue] as! [String]
                    
                    let model = ArticleModel(id: "\(id)", status: status, author: author, title: title, body: body, postDate: postDate, authorId: "\(String(describing: authorId))", images: eyeCatchUrls)
                    print(model)
                    self.articleList.append(model)
                }
            }
        }
    }
        
    func parseJsonForArticleDetails(json:Any) {
   
        let jsonObject = json as! [String:AnyObject]
        let article = jsonObject["article_items"] as! [AnyObject]
        //let sectionCount = article.count
        var index = 0
        for elements in article{
            let inputType = elements["input_type"] as! String

            if let content = elements["content"] as? String {
                let elementsModel = ArticleDetailElementModel(index: index, inputType: inputType, content: content)
                articleElementList.append(elementsModel)
                index += 1
            }else {
                print("blah, not string object.")
            }
        }
    }
    
    private func parseAuthorJsonData(json:Any){
        let authorList = json as! [String:Any]
        let authorsNode = authorList["authors"] as! [Any]
        for author in authorsNode {
            let authorDetail = author as! [String:Any]

            if let id =  authorDetail["id"], let icon = authorDetail["icon"]{
                let id = id as! Int
                self.authorList["\(id)"] = icon as? String
            }
        }
    }
    
    // MARK:  HELPER METHODS
    //Check member property: 'environment' for either dev/prod
    private func configureEnvironmentURL() -> String?  {
        
        var url:String?
        
        if environment == env.prod.rawValue {
            url = authHeader.prodUrl.rawValue
            guard let url = url else {return nil}
            return url
        } else if environment == env.dev.rawValue{
            url = authHeader.devUrl.rawValue
            guard let url = url else {return nil}
            return url
        } else {
            print("Environment does not exists.")
            return nil
        }
    }
    
    private func checkConnectionStatus(httpResponse:HTTPURLResponse) -> Bool {
        if httpResponse.statusCode == 200 {
            return true
        } else {
            return false
        }
    }
    
}
